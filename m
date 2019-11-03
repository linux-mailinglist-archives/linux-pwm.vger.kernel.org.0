Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F347BED4A6
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfKCUd4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfKCUdz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so5884506wrs.11;
        Sun, 03 Nov 2019 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=rScCDVYAK99EmODONTA/zLslI5PPeLsDXatQERQgwgA/L1IsnBBwSLc0SWKfnGkr0V
         tO+eMnTyOhKhAts5a8X6BMNcgekH9GZj2e5nGN6LK0CI2kg4mVwgwSIy463sa9U3JBzP
         ck8gOgC4+Sst5rWs6AwXKvjWBNKpmDhrAEdiwKmg+Qzq7JreuvPff13x98wa6qqf4oeC
         QiXjM4cQdvhnFJcRLGIoCeBb/sp7rT+i/nyP7zGzt1DPTOlCznlV+QPxQNBH3FWL4TPF
         KAo9JKbTl3BT4/tq5KqvW++LPFYXvdIUkssN6JGMdB1qZmFuSjNdQz6Mmu6wBZVzhLVw
         cBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=Lya1kz9zvuvWRezfn/kDuZgiJrAhpFY89xAktjkKKrOlE2WFsMUQsuOXf92RkEHHXy
         NYb6d1sJxbveEuELoQa2OKzyln1knam1G5TKUHfhvBOPiFDW/H7djkVxAWhgRWTKeshT
         +j+rTpkl+FH/cL9AG9jTZFM9gUuEkuq3TzyKsN1POt5BwvW7iqXQu9etWTDIdsod9i9T
         FtH5Avsywo1IEKIo0dgyWdlXkCEdjG6V5hEpFmPSYMFahMHFYO0WJg0VYjxoHrElsfEe
         0M8eyLBrXlxzWGI75WC8Ie+2tlTr51HTA7y8TvScLLBhnKy/6CYz8g0XY8h46F3MJadF
         5Xtw==
X-Gm-Message-State: APjAAAXzFAzoy5eC6Ejq2eKkMtSdxslc1ThpPBxtrRVRBnikgdMEsZEF
        G9GKzSaOBIsUG4tcdjEeYZo=
X-Google-Smtp-Source: APXvYqxCZXvry5vWKLLOb/PvIjc3nZ68tKRkjmzyDsMmPldkPt9HHS4QwGEpD8ISpJBeW6forCSG9w==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr21193654wrs.346.1572813231572;
        Sun, 03 Nov 2019 12:33:51 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:51 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 7/7] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Sun,  3 Nov 2019 21:33:34 +0100
Message-Id: <20191103203334.10539-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 1d05d570142f..38aba7e5bbd9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -131,6 +131,10 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.20.1

