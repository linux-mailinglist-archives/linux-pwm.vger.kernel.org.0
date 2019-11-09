Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB8F5F10
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2019 13:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIM3A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Nov 2019 07:29:00 -0500
Received: from mout.web.de ([212.227.15.14]:46267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKIM3A (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Nov 2019 07:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573302415;
        bh=AQ/eXQhL7XKePKt3K1mFZFA8OiMhHng6QZbb0QmtvZc=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=f6C0TwCPIagB6oP1X11xxVjSTpgd9wv0Sg8oG4+0JQT/cKEg9pKCn+YM03FfKy11S
         12//UomNSo6g/rIWTzmdvCpNQntbytu2O/9K0eHfGms+vAsbjFLcxRcLEmj0BkKUls
         AbozWfrv0jiWV1nwr+CkmQ7prnDvA+8AARUVb9zc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.82.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjrU9-1hwZ313JYP-00bsMQ; Sat, 09
 Nov 2019 13:26:54 +0100
To:     linux-pwm@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Keerthy <j-keerthy@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pwm: omap-dmtimer: Add missing put_device() call in
 pwm_omap_dmtimer_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Grant Erickson <marathon96@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Neil Brown <neilb@suse.de>, Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <fd7a56e4-2a35-a6c4-e5bd-1e53a6c48687@web.de>
Date:   Sat, 9 Nov 2019 13:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yu7LEgpvRSuXya5WnRjWw4eoR0eWF6NU212zZeHtdsg7K8WH6M6
 cbmJ9PHfP7iT7zt7SnLrzMQYzxULIW1COc2593KKAySIVuwA3/7WcKSeegE0Y5v0/97CcJp
 cXyiHEptIdBGq2wDMLd8AWKaXhK2JxY0Jql18rdK4Dg41F6+RyySCT90I1nlazvmwrsWzg6
 FRYG1nFkah5/jH9ikERww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gxkprVtV6u4=:Cbu6CSJE9DquIpYdmSps+K
 tDg6EPoWQHm11nhGF8fKPxm4b1yfV2YsePzUimZ8tkGHXW9mto/eJEY4i6y+ToQZ2z2VrdEXG
 +qljeuvgX+IQdcVPeqKb13tMRSxn0ochCsnF3OpR0S/bMCWsFgaQwi06lAExWowUg/jmLiAhd
 VhkZs6k6cEvq4cEn6IYFYFbEuYJSA8JOHRBmbGYeSvOBFiKBkdt8YDeUlGnZGz1OcEqc/4q5C
 JzB2Kbt8XtcnIcRXvrj4gLfNYrLmBFCEMo9b9KJD3zwCWqsh70dSg9Qcy9A5jN2zjeNyGVTli
 E1+VRi1qqww0+Z5R/IU/SyL515Tv149K9BzezU18AgktBlJWQm29ncsPesRAJVoYHQ+QAi4py
 +PeHC/jyZfkeGG/q9l5WILQh5ERjbnJ6reS1WbnW13O1XqyyWbef3AVfJhEb/la2CzsZhRCib
 IUNxeMXOILVGfOKpkqfML/o2JdLIr+DQAoCC0N7jexItlXfge3fPtIbog6SXrscC1QKxygqyM
 I2HDwlXtsEAfqjkG0gdgxx2aBZmel6Jo1HgtZXgRLIb0zhztThYEGFOJLVX+wvRqQU69f6jsp
 IZbfaEoSVLdC7aYBe74OhzDVSqmIbpxyL9dmeEJlpsQwPQCTnkIPWSaea0B5D7R25+hjA9s6s
 T++jjJYMHIJ9T0Kp3xd7D9icocacJ4bNqxNhv4jydh8ZSckkcW9/nKPfJ8BgQJr+wwjEUGUuk
 ArUxzCqxmNFOCYksn96kPDeAeNK1gTpqvSKmVjmPFmllrZ0m1fsAi4msozLP1YgqFa4mP8V/D
 Ifg8gEo3jlKD3AbYDH+Tu53Gbs2wfyJBhH+VLKOseWpNre6SAlFUqey+tZ36LTwiJcjWxxGXc
 rUc8/wxHw4ZyladEfhUqw6hMzqk0sGD9OeYoNVWzSrjiZiJueOaK3mm3iPo5nA15lVJxW9bTv
 M9iQ2XEiQT4J8GbdgJwnx4/en+nPABXPopkhR4Dckim/WBS6MFds/IslInRjx+4T6oRgR6Atq
 fPBEUniu2bz5ZDsFhBw4V3iIb6S1a88ls6F+q3z3juSjNW0sbOY75wMwARklr9rULau9s6alY
 0SJl4/E9hojWMkc4n6syui1IQzJWKE7O+lS/2yOS7ChX3kivfMpSKxswF2MN7YVrBX1TdDOpO
 6mzHghZP4rLGjy7lBftbTtVKoWB0nKJQNsmFh3lBXLrFJa4aEV//UpjPuikJIYEUYs/e4EIaG
 SxHoha0bdQFGbFxZjsWr3NYpSnjp9vf9VUTXgT7a4a8jnR0VupQNQw9vvHoU=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Nov 2019 13:09:42 +0100

A coccicheck run provided information like the following.

drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
call of_find_device_by_node on line 255, but without a corresponding
object release within this function.

Generated by: scripts/coccinelle/free/put_device.cocci

Thus add jump targets to fix the exception handling for this
function implementation.

Fixes: b7290cf6ff7869ec12070aa146c370728cab62c2 ("pwm: pwm-omap-dmtimer: A=
dapt driver to utilize dmtimer pdata ops")
Fixes: 6604c6556db9e41c85f2839f66bd9d617bcf9f87 ("pwm: Add PWM driver for =
OMAP using dual-mode timers")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pwm/pwm-omap-dmtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer=
.c
index 00772fc53490..958854213786 100644
=2D-- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -301,12 +301,13 @@ static int pwm_omap_dmtimer_probe(struct platform_de=
vice *pdev)
 put:
 	of_node_put(timer);
 	if (ret < 0)
-		return ret;
+		goto check_timer_pdev;

 	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
 		pdata->free(dm_timer);
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto put_device;
 	}

 	omap->pdata =3D pdata;
@@ -340,12 +341,19 @@ static int pwm_omap_dmtimer_probe(struct platform_de=
vice *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
 		omap->pdata->free(omap->dm_timer);
-		return ret;
+		goto put_device;
 	}

 	platform_set_drvdata(pdev, omap);

 	return 0;
+
+check_timer_pdev:
+	if (timer_pdev)
+put_device:
+		put_device(&timer_pdev->dev);
+
+	return ret;
 }

 static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
=2D-
2.24.0

