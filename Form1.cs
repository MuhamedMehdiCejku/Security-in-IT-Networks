using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication4
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        DESCryptoServiceProvider des = new DESCryptoServiceProvider();

        public string EncryptText(string plainText, string key)
        {
            des.Key = Encoding.UTF8.GetBytes(key);
            des.IV = Encoding.UTF8.GetBytes(key);
            byte[] inputBytes = Encoding.UTF8.GetBytes(plainText);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
            cs.Write(inputBytes, 0, inputBytes.Length);
            cs.FlushFinalBlock();
            return Convert.ToBase64String(ms.ToArray());
        }

        public string DecryptText(string cipherText, string key)
        {
            des.Key = Encoding.UTF8.GetBytes(key);
            des.IV = Encoding.UTF8.GetBytes(key);
            byte[] inputBytes = Convert.FromBase64String(cipherText);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
            cs.Write(inputBytes, 0, inputBytes.Length);
            cs.FlushFinalBlock();
            return Encoding.UTF8.GetString(ms.ToArray());
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string key = textBox1.Text;
            if (key.Length != 8)
            {
                MessageBox.Show("Key must be exactly 8 characters.");
                return;
            }

            if (string.IsNullOrWhiteSpace(input.Text))
            {
                MessageBox.Show("Enter plaintext to encrypt.");
                return;
            }

            output.Text = EncryptText(input.Text, key);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string key = textBox1.Text;
            if (key.Length != 8)
            {
                MessageBox.Show("Key must be exactly 8 characters.");
                return;
            }

            if (string.IsNullOrWhiteSpace(output.Text))
            {
                MessageBox.Show("Enter ciphertext to decrypt.");
                return;
            }

            input.Text = DecryptText(output.Text, key);
        }

        private void input_TextChanged(object sender, EventArgs e) { }
        private void textBox1_TextChanged(object sender, EventArgs e) { }
        private void output_TextChanged(object sender, EventArgs e) { }
    }
}