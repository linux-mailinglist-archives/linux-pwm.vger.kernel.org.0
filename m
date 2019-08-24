Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512D39BE25
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfHXOKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 10:10:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:45933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbfHXOKT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566655797;
        bh=LypcnngedSoYi/RkvPcTz6HY4amHhNBvxl4IISgkoSQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RuCygKrGtCZMe0DwFuYZnvgU7jOth8iCmb+vQvQgmY58svTv9qo/7/0NJmwaav5Gt
         kYwADxpCzgkS4mkY+Eout3d+sWEjA+/G0+S8S5uJXZH7Fol5gJHxAa2pTYI/aAz0w5
         3axOf/wGRg4JHaUutEn/uCj8LzH1nOTFt5cSNd7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M3UZ6-1i24yF2pww-000ae2; Sat, 24 Aug 2019 16:09:57 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 0/3] pwm: bcm2835: Minor fixes
Date:   Sat, 24 Aug 2019 16:09:45 +0200
Message-Id: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:vxBxRHcdg0o7DcxAQ9TR8WvI9dqQ2/+fg62BFOHjfUcKOUv+spp
 RtG6RUXpVmZRgRdeoAg9296JFlfw8d2/rj1QPHagUVBiu+m2OytO/rRp9+QY50XGU5jTwlF
 wxdKcDjAinqqoj2MaJ+r89gModQsaz8UMW3OV/w4zEwyozJK9PPk3lQR0eWQp88R1nkCHRQ
 Ci1uh3KSVR4faTQv9uZFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vtBKKpo08c4=:4mO9Bp5cmgJiWpwJZk7wrX
 wj3mdsLSaNov2Gh2X68TlOcBAht2eZjsvfYOIh6ysCsNT7MJNfY0OJC1+m4T8LlBv09KrOJkZ
 nT7M8KwzcoX8BF5rJOoQYE6/t0+abCfO6SYZo25AW20oSfRJqaKhmY/7pEPJJcHqAg1ykQnm3
 sLqnelWYdyKkxdTIGVtStcu0OMAYaAOIusDKVMvXmKcYfwc2TI926tAvpnuVKaeYPDR5439aR
 VyChsfC4JsI14R6Huooqe6Nbfc9t9D78cSJrvCoLnHU508PxQnHRQLhSI/nxtlgKsTnNVTP3R
 OUWhGEEfwumZIeTJ5dIli2SfAJZ+EKrm9OgNx6MtgR3viw8rf84dSs+XJpRNTfLreCepvwPIe
 nZ88cgZAN9dJ0Xg1ow2KSNY13BlyG8f6IzBZy46OL5vBEA6j9aJT2EFbvz9r+uvrF2kWYEYPh
 mKDkVzutfDlJyJihrv3KsYUmylYWrvKV2gt1dEH/svn7L3ToVzrkLI21DRapTMN/Mk0OtN3I7
 9io8bsFPOUy1nCTFu5vIiJgxe9KYCbEezvzDxHz2jMFLtxywjX/vHBy+BB4hJ/OUL+o/gxK+h
 0gw9OQML6bGfRnGOe4Z7ABRrkT9OWq7oMNFQfL5CGV08izoOYvF/106iHLKTFQHX/EWbpXNj9
 t3RONgRLabSC9LVs+F+4Wwec3IghPWOdzqNNNH0Gm36IBkXATkyH9KXTD2oWnFdVD2rio7M88
 tSoF4UXmHTWXvfdFZQyDsA01oFb/GbmvVVvbXslTB7/18x1SH14VGh/S669eYliJouTftuD6q
 kx+cuBzAZUQUgdRHpg28zHQuP8sag0Hsr1ByD5XCHhqmkkbMVTHljcOYxt5sqvi+NntlOfgLw
 2DSyeFeDa3pARIz2UOttPGf9pUWUcHhSIkC93KaVPV654c5/3L216YkFh2ZxfVQDMKC/DIe7S
 54A3Qvpbe81AZrse/0g9YRDoXOBwD4Cfc5uW1uwjp/+Lbt8bkyzwzWY3FgUPBiQzlFXotZvOt
 BLXZ1GAR1mvnY1gn/3Dpj8LnXJS8SQFQW/YBG1jDVk1ChVWJ6uFsv5LhwdiggFuPeuXn3j29Q
 hHJCXZc7s99a60i5yX7ZwIWeltu7GR59x7Dilzkl/eO1Fs8CzGDPSwOs+aPS9paCLq6cmhZvF
 wLK2CTBzP6jmt4asARr7rngNMCXhww94guL91Wv1/jnJt5Lw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This small patch series contains minor fixes for clock handling and the
period range check.

Changes in V2:
- simplified patch 3 inspired by Uwe's suggestion
- add Uwe's Ack

Stefan Wahren (3):
  pwm: bcm2835: suppress error message for invalid period_ns
  pwm: bcm2835: fix period_ns range check
  pwm: bcm2835: suppress error message during deferred probe

 drivers/pwm/pwm-bcm2835.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

=2D-
2.7.4

