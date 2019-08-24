Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26349BE23
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHXOKN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 10:10:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:53999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfHXOKN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 10:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566655798;
        bh=rRIKSJq9ObxQ/pOOw2ApNgV/oQBg3tBp8gJFC1ntmhM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IzQqKi5xE2IcwK22fDz9kIIEKC3dBzfKooZPjztmD9kUrQpbB3UbgVUshGrC3VatH
         XoFItX5R1B2QmZD3afTPnoPQRxThEon61Olkw/zoVHMybNUUn3BbbWR87tY0z1EM/N
         m515wEKPl3KN2Utjz+pl9i2+jrfSZ3Zc8PUGGdoQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmDIo-1iS67C2oWe-00i8fo; Sat, 24 Aug 2019 16:09:58 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 3/3] pwm: bcm2835: suppress error message during deferred probe
Date:   Sat, 24 Aug 2019 16:09:48 +0200
Message-Id: <1566655788-24949-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
References: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:32UdlmvSNs+Bubdd9WzEPRfqqlhDYyyRN89kD6V073ChqdNlB8+
 oR5pJwySQ84SvsTgYT4srJHSz4V8X3EOCmE/Aj9vIJrYg+81erDalw9X1pj9gGM1YQfmmTZ
 ugGNNncxu28nqRMMVzVVMf6pwpAGqhnb+zdJypv81Q4nkbnYUArHNWeRn1AFNk8rQBk/v8j
 mOfC2kdPPNfzfxnLisa3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhMKr21ua04=:nJy53uGPEf2MHM+JqTU8D0
 Jriu2LbdknOxCIznnwPY19RodlJOyQMU0xdCdvWDiq7fvoeBJ/55CcqTSrngrxlRm56IWpR4Z
 Dotok7jb8JCrDGmMOmVS8hpIAAXnAsX5ta/36PUVbXkfonpiGWpXJI0KMR4n/nUdAuruiHYsa
 PSM0lY3q7a5U+1FPnQyC4h1VVqD7FyGmMcqVemgPBK+5d92eM7x/q5nB8wH242samcL+j7m55
 NXX8a28F4mYvuHhxz7/8Q+xJk1h7DcPEAvV2g1Su6ppCC9bTSHTIXKzdwMuyp4Vz2YeaWBzUk
 j6BPdK1HLOYPzv/j0mRnCAsqqMkIZSgGSbvjsBTVuU2XUA2CE4C4DbXHyDkmbU5/GMkKGAx05
 ToeTJ6cQgCCbapNd1QrBOzB2GE+VE33BGjz4Op9brjJeFMp7CLLKzwtefXsepdAb47tLk9CrW
 jy5u+0JsboeqMG6jibmCW5e1Jcm2ZNe+0hFBmoRRD0iKUACkzeESJxXfxidXOPprI2cn0eknv
 2kfYbZa7M4kpvTrY35FQ67SnH5sqEA2mfixdOF+EC0slQUvz1+bUHVPm0Tg8e1CMEiITIy62R
 Y6k8mfHuQekkEPYoDpEtzoSbQrBvuxXpYd2jQgywNLB5WeLPZgqBt4nz0sJekiCJ8hJImy2Zi
 LlKB+0GYMyu5zc11lle3dZWed9U9x+2A4B+gFOpTCo9JW8j0e4tQTWPqIU/HyTuimlK3BxpPF
 IIWgKzWBJ+vE0gK1UHNj894y/OQOiRt03f7lXaNHVSojG3am7x+8Rjs0ZRyHBqQxZ880UsvqP
 grAoGHNnDc0HUMPFSbg4ZH5BBMcP2CVtmkTyN3ML8wUIIJwH5cQHlSifPHD1LFQa2DmlZNt2r
 6g+TBuDXEu2mTh7SlgIoI2OqKDezYSuyYFmhn3Z1GdPSmXEqD67tyf3fNCiVVjhe/IKLWL/O4
 1XuOUCH00v5XUkLV1h4TJNUaw21y2i0Vyzm3CaXX/ERh5gH6cAfmUvEpihBKuSBt4HYWIFOUG
 zCRC4DI0j61cbaZvBbuLdMoObHfbjH9si+MEjnBVHMNuI6aE+sLs4JfmySw5zS0T86LMXqrMA
 r/tGmYwi6p4GsL4kVRm1ZBHpg3y/xwIT2XhQJBWeacKuSSyrlx9zA4NCg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This suppresses error messages in case the PWM clock isn't ready yet.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pwm/pwm-bcm2835.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 2c82386..91e24f0 100644
=2D-- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -153,8 +153,11 @@ static int bcm2835_pwm_probe(struct platform_device *=
pdev)

 	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk)) {
-		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
-		return PTR_ERR(pc->clk);
+		ret =3D PTR_ERR(pc->clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "clock not found: %d\n", ret);
+
+		return ret;
 	}

 	ret =3D clk_prepare_enable(pc->clk);
=2D-
2.7.4

