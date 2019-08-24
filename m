Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B889BC50
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfHXHIA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 03:08:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:47755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHXHH7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 03:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566630464;
        bh=MB84cv/KL61N5vEmJ6+3TzMhv+UMcSlJU00FuLqAzrU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TeryD+a12udrVP51FXUZT6+1uVeoL5/GsgAGw0m91KCU4/69KNsUAy17oEGEHxBRz
         CcrMhGlV9k7Me5UeXyhguzMvzbOyDJpijkTa/9h2jFvrK7kpRAKsnSSeYdewak7+0r
         NpAMA49EEWWIEZ7LxkMDuvedTm/xl0o+5t1tFXHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVvPD-1hcIdB1Io9-00RnFR; Sat, 24 Aug 2019 09:07:44 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred probe
Date:   Sat, 24 Aug 2019 09:07:25 +0200
Message-Id: <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:vSh+FWB0hIgx87Ju8ImsCa1tHiFyOl1sni3i5VO3MMQcFsr1yVv
 T6YDh/7DK1cfchpa7U2REVHF69x2UCsx9F928SGJ6avsB06jLrqjWq/sfjQcRFfMSECAKKL
 pufGrMjAvmTxaTSEkxeac+vwg6bifMhF45t+5LZk+1Wqe94x6kPmgXiCj8iWMWGALvlFntO
 oODfydGw0LDFsPWrY4ANQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4/wiuCA+KLA=:ySVx7KJdsxd9TLlv32vmgJ
 ysdV6Esxf1Hx6VAmQzDPoNcWoTPtKEmWyXWBJbVwUfwoDHlUshk7CUUbYzSAz0VHI9g7O0IrE
 A+zeu8iMaEojrN8HvmnjAXFUUR0w3YLSuJJomGdpvXVWm7OpbEdgtz153oKU9JRPvVHqsmdwD
 FFoFsMGKMbpT6l613Ga4y0rr5/ZpABtw+HlgbbH1SRE/6KT4GhXhbA46fjyI/1lECOeETwPF5
 sNNGeqHKJcZFW+iUUB2J5oW47LK7whN3fYo/z6r1cVcGLp7ADhdoDplhSZYUnTAfLljiaZPJt
 0zb4KSNrWQePszVGZ3VPgkIQJbQyLCjvq7txU7n2B+P+WTqxwgLQts6PtC3WtvT3zuEhjeoY7
 UQ+hQB5rynAkRkU/WEAOmGz6L4TlE5w1U/W3I4YbFVwXLOMpW8vITZZP5YeMY2yQwqJYGZdgR
 u3JwIWVYsfVPiDx3tR+Yg1ZtXVsoUdG/K8islNYBPyzDsQ8pUsuSqpgtyw3E9FkQngkpwAwEk
 cVJKVkZfiz3Fo64z/I/OcDocAnkMP33frKGB1kifOSTDk4X3QHg3ktEH2wAQpujcwXULZeLCC
 zyw6FRjy/xMsWhkrlt/9O0obPrEMwmh2F4p7BWCFHrZrHCzXCd8Kx6RnWz8qohcVNGcUkO7LT
 nljWcv3OLvV230nMNzH0pLCUsBCtF1q9ERp4UYOe1RNo1VsywTSfb0kGN8/zT70G4QUXf2ntj
 bJbMc2xjl1o+T2Ny57ioc0gpHmyq3MC0Qu72iOPZIkqEbPvzcMVYbzGQyMI9qPP0x4i5Uk00e
 UK5BfDp/xsHh15gkD+HCpodSnE+P96J4ThNO0SKF5wP3h6UbAWZE0FB1Y4UvIvfv7oQWhHqrI
 0MxaXpHHdEpWsychVCh3fbD8hmaYknZI3JY37EJzSRsNXz5ArRycYAH3RMVt0gZZqagIkq40X
 MEoaNUnSapCztsuIdj1wn8HeK2k8dHq+2yCKxaN+/YqQGbofL/foJ0j6Vj6v2TT3FfBtdvWZU
 7fHIw3z0wbM1BLnjo96wn5M0QNNpLo7+kMCHaYoRyP0rLW+P5m3XfguJEy/tx4L8L2jJJ//kz
 W98XoVf8RARniKqcrtUiBnUd5CileaO11eCT1cIC9vovhxmVqqJMzTGyw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This suppresses error messages in case the PWM clock isn't ready yet.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pwm/pwm-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 2c82386..ce362be 100644
=2D-- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -153,7 +153,10 @@ static int bcm2835_pwm_probe(struct platform_device *=
pdev)

 	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk)) {
-		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
+		if (PTR_ERR(pc->clk) !=3D -EPROBE_DEFER) {
+			dev_err(&pdev->dev, "clock not found: %ld\n",
+				PTR_ERR(pc->clk));
+		}
 		return PTR_ERR(pc->clk);
 	}

=2D-
2.7.4

