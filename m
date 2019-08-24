Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70C9BC4D
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfHXHH5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 03:07:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:41649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHXHH5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 03:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566630463;
        bh=PKxEsX2rISWKrQgeMW80jwB5sy0XViIuMLHUBk/9zKE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RTrS/Au//V1m6EYSNRGyIyWBvkOzVWmLtAKoLO85mRng3Yfk4MqUCfkhnHGB3kVrG
         a/zdlsKo6pec2dmUo0tW++x+FoY1IoXma25AKsTP7Ius0tIvPu4Vk/IZyCY2FVfvbG
         sBiAyfZXZSp5yaVzG2QMNdP8nYoOfVfhsZVeZ7jg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgNh7-1ij2Dw1QY3-00hyJX; Sat, 24 Aug 2019 09:07:43 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/3] pwm: bcm2835: Minor fixes
Date:   Sat, 24 Aug 2019 09:07:22 +0200
Message-Id: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:5sT5Ex7dt/31unK59b6877E1kyCY1ETyVze+xHrp/25aGjWqyKl
 +7UxjOl+imgWagWboabnY3NcHgxK+CTt4kfy1Ht75YBHE1BnneMkaHKFPl8TdoAZDIiBiqK
 hUmE0zLqxBUYPy4a891QFuSrkIOkb5FCS1q3H6jLWFu3jdTcbSTcFNrMx/ep6sPLmhk1Hvx
 3SFtJU0PsIP4P8lgQIHUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0qf36lRIz0=:QFZR3QfKNKspBowGFNoHnQ
 pTKW+L09U8yVdh2YPm9XE/i7ni7VMagHaJWIHC2FZFlKg6hiFJIB4WmV+GUy9cjveyexVnf1d
 eGbFhRu0HzNBrgvzNCfPUWvcCQv4tMbrR1mte3lhwahkilubNecAI9ipmBIaNHmypq+60hsi9
 HUl7d5OLjxSkCL+WVM9DdFiAgRs3mUEr4Q5jV84mwOeGieLvZ3T21A07ZfG38R3wOz514vIMK
 k20jQrXUzjPdxKGyNC64PHx1N9fmwVtV33oilrTUZ938MAAPodzQKbhZJfCGtDAicCOYhMCaS
 0I23OKtA60/y+jfZptz1bYnqA4hRzIFjmvc4kLi9L0/L+dvR5Lx+a4/I/iP8P0dmRzkysqFuJ
 yQEjcmH53M3Zou8J255U9+pSFmjrRiyHvscodlJtYSKsQ1BU4WtR31RNV6XGT+pH48KKKOCsI
 q17kOfLlNAXo22TNOs42Wt1ksI2C3ralBFiqTwgeK/bxTZI/ktrKqNYmhE60zu/Tge2+PAhiG
 6tbfzSO0UeHsiZw85eEOHp4NeReDxIFYwRQ1sLyEdn8VDl9w3sWg1wZ1zzAu6MAY+6rzFAsP9
 lgvcn3asr4fOsFgsokd1fnJolVhtxrzO6INVZXnSP8jFXfuPGtWBnaHbjkBIltt6zUCQ9AqB2
 i7xbRjutAHwnhD3utc+jeXloW6fWhs26dK3xBBHZwoJ8dV+uYkCjhvMzEKNClNNOjE6R8t8iI
 ZL//qUDLT9e/XVJZ8yonEI/oL4PMFjy1eEx+UVqyMnBYQYzQbFYc8xPgINOYP8TiRvxRCcXsw
 qBmGryLnUs9OTMdck2NDUYfC4Fw3uV5RnXbP8bV1+/zXXcTAxgUfrEJ+CKBAQbt8zcCnV9MAR
 CX/xdvGIOQnP/OVVlrGM6xYootULsHoOc+XAZY6mvFdkweqbnkqmVWMyCUj0zTQxeQN6DLnCG
 ytvpr0/ltTdLQt9Jnmox1EznIUOeoYL7hCAXTIuWGUtB9z/gvAnWRInpTTaNyCrVjHzNaeHRY
 L6a5jD2FWBJTcGQTnv4vmWpuyLmeD3RsdRhtQTdd8PclewWaC9f36BkPE05dgRsiIKCc+KBbw
 Sp1T1X2jb7g5VHfSQlnR/H4fR8O9ixmSIuknfBsDfn3fz1XYDVnRwtKlx7NSbrUsLZHE9CHGM
 36/T40kjbsy00Dw+nfc0At7DbxwG/ZDhtT0BCCCswGBxkEIg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This small patch series contains minor fixes for clock handling and the
period range check.

Stefan Wahren (3):
  pwm: bcm2835: suppress error message for invalid period_ns
  pwm: bcm2835: fix period_ns range check
  pwm: bcm2835: suppress error message during deferred probe

 drivers/pwm/pwm-bcm2835.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

=2D-
2.7.4

