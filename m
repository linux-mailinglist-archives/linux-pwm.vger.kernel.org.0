Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0962C6E09
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Nov 2020 02:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgK1A5T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 19:57:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:44957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbgK1A4t (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 27 Nov 2020 19:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606524989;
        bh=ZzHUIAcJkfQ4yMJ+3D8uhEGiaG82a6I1rM1VddR6Ljk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RZh0tbC7BlG0urshsTaRhgFxZFwJwAE99KQ9gqlTWfS07OvuIide2+xUBup1eB/bA
         493XIIWAPsKeAB5nplcU0KoaAKszBiRb2uSqx+omZNsDKoS3BKQyqXMgBk+XZQXk8c
         4L2z4x0YlwL2o9Yb3H78x+ST82kV8ZqwYZOVootA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1kInRX2KxO-00igwL; Sat, 28
 Nov 2020 01:56:29 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH] pwm: bcm2835: Support apply function for atomic configuration
Date:   Sat, 28 Nov 2020 01:55:12 +0100
Message-Id: <1606524912-16683-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:jdfU7DsUEvhMkWh8Prv5e4yo2mrgbndU0LflzdY48Lv5rZPE6cJ
 2s7lKs5atD/6eozd9PQDBiPuGTV4mKVTsRsEMM9JxYr6tEW9Xii7Y1QmBIk+I40LvULPejH
 SFVQbnUguaqaAR125/XzqnmsPGnGYN50LM2f9iiu9oF8WA7CGbL+uRCVLgbOw2SJWQUCLxI
 eCXXmAo6KONu6luLslK7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ymX10MsVhas=:Cgj/yIxRX4k6/e+KKr3Usp
 Kr4vbvRCOFUnGClJOdcte3iAemlH+Iqud0V54Lss0U0+qgFEY+/ZLxDfREvOGyI0qf68cFOob
 piVdq0acfdCkNpVIfrPbDZFRzMRyX2K/no499Vt0x0P06L7pyb0C2WhZWmXXASo75Af5PTgeJ
 7yKUL0QzR91fWo/3nUOqpACAFdtBjhevk90LLnZ2RW6zp+JZLZe42L9y3fB3Dv4Fmx1GNu6JP
 I9kR61MfvLCBr5r+jlFfU7vCkr7r1NXkfY0gvQmVOCDXWwMPcBHMXh4ORAuUo/9tlJUGhhcT9
 qmCzrUZn/ead1d6VvwE2XZG1Pj4TQwpPGktwBBbSx/e8DjL92KCsxW54QF7rAXBWQNXObG1qH
 HhccDMOgtt45sgCZzUrNFdNVK7Iu9QfoZgDBD9jMSg0JV5hQlCg7F3Z+EtNpYWVqQOob4VW44
 5D56CGmYAcjSa5YTClTvh46MkATqQYXo7UncBjMR4muQCSDg+PdcEZsfG25XCakVJc2H/GTjr
 giCvkqgiBXpnPXN8xExo/qccE+oMHXYV1AzY8opT41YSDy6qn3RvrWAHyo1euvG2RQOpOcmNh
 0kLWp5uqYtWRwUszAOQM+LfuvVPijVr1aM2Y0cMKNrgElNkTnvN5CF1mzdbjWbDp3GiKJ/l2E
 3Va4Wg+LiAh3W35w4MywWErLFOmz7rRI6d9KvwKO79CesDqfntCP/7wECyesezZRtvIXeEEdB
 Bz3OrPbpgSz4oVeagLSXEuSyw8wbp9xm9CLVLMXXvdSddznLFGuZrsGBZXqjcVOIkNfSofZkW
 71Id5q0dvcYG3hLEvjCTTeClBAn0zV0o8Epx6QcOy4W31CxxGv5PM3GECaY6/x/blHE3n9HZH
 uukY62E8stXfHj2ciBHA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VXNlIHRoZSBuZXdlciBhcHBseSBmdW5jdGlvbiBvZiBwd21fb3BzIGluc3RlYWQgb2YgY29uZmln
LCBlbmFibGUsIGRpc2FibGUKYW5kIHNldF9wb2xhcml0eS4KClRoaXMgZ3VhcmFudGVlcyBhdG9t
aWMgY2hhbmdlcyBvZiB0aGUgcHdtIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbi4gSXQgYWxzbwpy
ZWR1Y2VzIHRoZSBzaXplIG9mIHRoZSBkcml2ZXIuCgpUaGlzIGhhcyBiZWVuIHRlc3RlZCBvbiBh
IFJhc3BiZXJyeSBQSSA0LgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2Fu
ZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy9wd20vcHdtLWJjbTI4MzUuYyB8IDY0ICsrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wd20vcHdtLWJjbTI4MzUuYyBiL2RyaXZlcnMvcHdtL3B3bS1iY20yODM1LmMKaW5kZXggZDc4
Zjg2Zi4uMmVhZGZhNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wd20vcHdtLWJjbTI4MzUuYworKysg
Yi9kcml2ZXJzL3B3bS9wd20tYmNtMjgzNS5jCkBAIC01OCwxMyArNTgsMTQgQEAgc3RhdGljIHZv
aWQgYmNtMjgzNV9wd21fZnJlZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2
aWNlICpwd20pCiAJd3JpdGVsKHZhbHVlLCBwYy0+YmFzZSArIFBXTV9DT05UUk9MKTsKIH0KIAot
c3RhdGljIGludCBiY20yODM1X3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1
Y3QgcHdtX2RldmljZSAqcHdtLAotCQkJICAgICAgaW50IGR1dHlfbnMsIGludCBwZXJpb2RfbnMp
CitzdGF0aWMgaW50IGJjbTI4MzVfcHdtX2FwcGx5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3Ry
dWN0IHB3bV9kZXZpY2UgKnB3bSwKKwkJCSAgICAgY29uc3Qgc3RydWN0IHB3bV9zdGF0ZSAqc3Rh
dGUpCiB7CisKIAlzdHJ1Y3QgYmNtMjgzNV9wd20gKnBjID0gdG9fYmNtMjgzNV9wd20oY2hpcCk7
CiAJdW5zaWduZWQgbG9uZyByYXRlID0gY2xrX2dldF9yYXRlKHBjLT5jbGspOwogCXVuc2lnbmVk
IGxvbmcgc2NhbGVyOwotCXUzMiBwZXJpb2Q7CisJdTMyIHZhbHVlOwogCiAJaWYgKCFyYXRlKSB7
CiAJCWRldl9lcnIocGMtPmRldiwgImZhaWxlZCB0byBnZXQgY2xvY2sgcmF0ZVxuIik7CkBAIC03
Miw2NSArNzMsNDIgQEAgc3RhdGljIGludCBiY20yODM1X3B3bV9jb25maWcoc3RydWN0IHB3bV9j
aGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLAogCX0KIAogCXNjYWxlciA9IERJVl9S
T1VORF9DTE9TRVNUKE5TRUNfUEVSX1NFQywgcmF0ZSk7Ci0JcGVyaW9kID0gRElWX1JPVU5EX0NM
T1NFU1QocGVyaW9kX25zLCBzY2FsZXIpOworCS8qIHNldCBwZXJpb2QgKi8KKwl2YWx1ZSA9IERJ
Vl9ST1VORF9DTE9TRVNUKHN0YXRlLT5wZXJpb2QsIHNjYWxlcik7CiAKLQlpZiAocGVyaW9kIDwg
UEVSSU9EX01JTikKKwlpZiAodmFsdWUgPCBQRVJJT0RfTUlOKQogCQlyZXR1cm4gLUVJTlZBTDsK
IAotCXdyaXRlbChESVZfUk9VTkRfQ0xPU0VTVChkdXR5X25zLCBzY2FsZXIpLAotCSAgICAgICBw
Yy0+YmFzZSArIERVVFkocHdtLT5od3B3bSkpOwotCXdyaXRlbChwZXJpb2QsIHBjLT5iYXNlICsg
UEVSSU9EKHB3bS0+aHdwd20pKTsKLQotCXJldHVybiAwOwotfQorCXdyaXRlbCh2YWx1ZSwgcGMt
PmJhc2UgKyBQRVJJT0QocHdtLT5od3B3bSkpOwogCi1zdGF0aWMgaW50IGJjbTI4MzVfcHdtX2Vu
YWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20pCi17Ci0J
c3RydWN0IGJjbTI4MzVfcHdtICpwYyA9IHRvX2JjbTI4MzVfcHdtKGNoaXApOwotCXUzMiB2YWx1
ZTsKKwkvKiBzZXQgZHV0eSBjeWNsZSAqLworCXZhbHVlID0gRElWX1JPVU5EX0NMT1NFU1Qoc3Rh
dGUtPmR1dHlfY3ljbGUsIHNjYWxlcik7CisJd3JpdGVsKHZhbHVlLCBwYy0+YmFzZSArIERVVFko
cHdtLT5od3B3bSkpOwogCisJLyogc2V0IHBvbGFyaXR5ICovCiAJdmFsdWUgPSByZWFkbChwYy0+
YmFzZSArIFBXTV9DT05UUk9MKTsKLQl2YWx1ZSB8PSBQV01fRU5BQkxFIDw8IFBXTV9DT05UUk9M
X1NISUZUKHB3bS0+aHdwd20pOwotCXdyaXRlbCh2YWx1ZSwgcGMtPmJhc2UgKyBQV01fQ09OVFJP
TCk7Ci0KLQlyZXR1cm4gMDsKLX0KIAotc3RhdGljIHZvaWQgYmNtMjgzNV9wd21fZGlzYWJsZShz
dHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20pCi17Ci0Jc3RydWN0
IGJjbTI4MzVfcHdtICpwYyA9IHRvX2JjbTI4MzVfcHdtKGNoaXApOwotCXUzMiB2YWx1ZTsKLQot
CXZhbHVlID0gcmVhZGwocGMtPmJhc2UgKyBQV01fQ09OVFJPTCk7Ci0JdmFsdWUgJj0gfihQV01f
RU5BQkxFIDw8IFBXTV9DT05UUk9MX1NISUZUKHB3bS0+aHdwd20pKTsKLQl3cml0ZWwodmFsdWUs
IHBjLT5iYXNlICsgUFdNX0NPTlRST0wpOwotfQotCi1zdGF0aWMgaW50IGJjbTI4MzVfc2V0X3Bv
bGFyaXR5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwKLQkJ
CQllbnVtIHB3bV9wb2xhcml0eSBwb2xhcml0eSkKLXsKLQlzdHJ1Y3QgYmNtMjgzNV9wd20gKnBj
ID0gdG9fYmNtMjgzNV9wd20oY2hpcCk7Ci0JdTMyIHZhbHVlOwotCi0JdmFsdWUgPSByZWFkbChw
Yy0+YmFzZSArIFBXTV9DT05UUk9MKTsKLQotCWlmIChwb2xhcml0eSA9PSBQV01fUE9MQVJJVFlf
Tk9STUFMKQorCWlmIChzdGF0ZS0+cG9sYXJpdHkgPT0gUFdNX1BPTEFSSVRZX05PUk1BTCkKIAkJ
dmFsdWUgJj0gfihQV01fUE9MQVJJVFkgPDwgUFdNX0NPTlRST0xfU0hJRlQocHdtLT5od3B3bSkp
OwogCWVsc2UKIAkJdmFsdWUgfD0gUFdNX1BPTEFSSVRZIDw8IFBXTV9DT05UUk9MX1NISUZUKHB3
bS0+aHdwd20pOwogCisJLyogZW5hYmxlL2Rpc2FibGUgKi8KKwlpZiAoc3RhdGUtPmVuYWJsZWQp
CisJCXZhbHVlIHw9IFBXTV9FTkFCTEUgPDwgUFdNX0NPTlRST0xfU0hJRlQocHdtLT5od3B3bSk7
CisJZWxzZQorCQl2YWx1ZSAmPSB+KFBXTV9FTkFCTEUgPDwgUFdNX0NPTlRST0xfU0hJRlQocHdt
LT5od3B3bSkpOworCiAJd3JpdGVsKHZhbHVlLCBwYy0+YmFzZSArIFBXTV9DT05UUk9MKTsKIAog
CXJldHVybiAwOwogfQogCisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHdtX29wcyBiY20yODM1X3B3
bV9vcHMgPSB7CiAJLnJlcXVlc3QgPSBiY20yODM1X3B3bV9yZXF1ZXN0LAogCS5mcmVlID0gYmNt
MjgzNV9wd21fZnJlZSwKLQkuY29uZmlnID0gYmNtMjgzNV9wd21fY29uZmlnLAotCS5lbmFibGUg
PSBiY20yODM1X3B3bV9lbmFibGUsCi0JLmRpc2FibGUgPSBiY20yODM1X3B3bV9kaXNhYmxlLAot
CS5zZXRfcG9sYXJpdHkgPSBiY20yODM1X3NldF9wb2xhcml0eSwKKwkuYXBwbHkgPSBiY20yODM1
X3B3bV9hcHBseSwKIAkub3duZXIgPSBUSElTX01PRFVMRSwKIH07CiAKLS0gCjIuNy40Cgo=
