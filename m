Return-Path: <linux-pwm+bounces-3525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EF993D44
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96D61C22CD3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CF376E0;
	Tue,  8 Oct 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAXikUT9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D138F82;
	Tue,  8 Oct 2024 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356684; cv=none; b=CXPEst0eYSNWyeFCZCOtJoseO8HD4U4M6NeSEeKPODrBHO+927vLu9O4lCatNCy9XlBlSjdzPIr3pgtkq803mea+lW/wk5PYBEo/JIKpPkBFcvF9FkiA5tin9GxumRc+xjmnv8rTm6x3e2544cZ3ppTZzVi+hUUEmqg/TEz/EKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356684; c=relaxed/simple;
	bh=kuKctZJOjS2OUZaqeOyTGjg/MdoY3xFfnNR1RUfMJ0M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY4nXBe/quIF/fQep1PpK5t3JNOaWsAA1B+B7FPaqPwD8DMfhr1x/esnrVtQcNtexdEBS7aBwBQdPxWhUnYOaCcbULCzE+8VsP3QFuxI4JCWOdchYHYgSgGbbxrRsPndxKlt6lsnsOjAG4kBfKFI9HahwJ0s1p8cXQ58E2lnYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAXikUT9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e399ca48f3so538946b6e.3;
        Mon, 07 Oct 2024 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356682; x=1728961482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVj0JZ+cVfOjaLAf/i9q4f7a0NWdixO3jwQiTDHespQ=;
        b=jAXikUT9uO2aNossZiNlERMean/mceVn07pRnuG9T/XDbzxHFV0SCKmnCzFLuxk0TG
         4esZfIJuOXY4DQYI/xH+7n2iWlXrHVCc4IejAfthYBnNbD0S0hJ8t6JC7ErLQ479nTFR
         cygT1Q1FgIt8yPhunEbLYDsS8Gh8lX358nVOFUdl4rD+Z1DI/CxtHeYWWXj8Cxr8yaAq
         bl6iZpX3sJj1DTBSIn+SQGgNTXP0aUSy5vHcTYvtSgJJkQ4+tnyWll6G7s2ZzC6zbMzA
         UCg7a5RXJB08Es/tVrh4R2OjDrxytRFZ8QYeXczYsyO6OTIf28PKt1PAaanvm9Totxph
         ciXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356682; x=1728961482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVj0JZ+cVfOjaLAf/i9q4f7a0NWdixO3jwQiTDHespQ=;
        b=jYqJfQgaBeABDkVONprF3ADlbjMnJrXXF5nZqnFHry8OtNGBqvnkXAFm+DafiAnlW0
         kTjdfyTAoxdEtmydqbFuT1BX5GzhalAmrbbDscsMU7yAwvZafuOotCviOwn9H5glJstT
         7GmZ6jntUsu6hiPJ47btwMisLiG47ItL+tyAafblrhBN+ljUud7SqMOwGg+Cb6td1bO+
         X1aA30stED3YiXlOwCUTTDrR/MPbpUImr5ffbcVP54XIA7yD5yQ9RMYki51/pVbss0FJ
         mVy92+hbwWC0hgs9lC+M2IBQbl9e54lgH8+1x/feUe4wC/Btr6hglZXhaaasFw59NwOJ
         UqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95+8SefCUeR4Hc+UlWny4XCE9RDuYD4h8F3L1CqVL50/SyCHI28w8CMDi5RywkagGw+rnHaMu/b0G@vger.kernel.org, AJvYcCVEeeC9u1ZqO4IZh1/y0TC90d/ukbR8BtYP/4xOPwkctQ3hEbQMfXoijBccezjNSwNopinzOxPbRBi3r+Ob@vger.kernel.org, AJvYcCWyZFAXWnKqcboxauHTA6w+bSZN/3FLCkIwZEbyis8GKb0nNSRzJma7C+GTS3UONk7Xw+r5FKa6GVVU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54EV7nyGY5Xh196BryTt/SITMtG3GLrrVLTZqRSjvlOTuvaBG
	li63GvQZKK8KMcb/9EM0BVNIOOJrQniCpfUo39kL/JPHqosxKyi8
X-Google-Smtp-Source: AGHT+IGf1MJT/PyvOPxEnoprcZ6XuCuypJ2wUdXV9XylGNoyRVkd8fbI1Fm5UNJ1EFp0uIMZBKBF0Q==
X-Received: by 2002:a05:6808:23d1:b0:3e3:a90b:25d5 with SMTP id 5614622812f47-3e3c133e35bmr8119051b6e.18.1728356681788;
        Mon, 07 Oct 2024 20:04:41 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3cf854961sm1282089b6e.10.2024.10.07.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:04:40 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH v3 3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
Date: Tue,  8 Oct 2024 11:04:33 +0800
Message-Id: <960826e94a94c1c0a25261e4081de7fa82dff5f5.1728355974.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728355974.git.unicorn_wang@outlook.com>
References: <cover.1728355974.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 has one PWM controller, which has 4 pwm output channels.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 4e5fa6591623..048792b30617 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -165,6 +165,14 @@ port2a: gpio-controller@0 {
 			};
 		};
 
+		pwm: pwm@703000c000 {
+			compatible = "sophgo,sg2042-pwm";
+			reg = <0x70 0x3000c000 0x0 0x20>;
+			#pwm-cells = <2>;
+			clocks = <&clkgen GATE_CLK_APB_PWM>;
+			clock-names = "apb";
+		};
+
 		pllclk: clock-controller@70300100c0 {
 			compatible = "sophgo,sg2042-pll";
 			reg = <0x70 0x300100c0 0x0 0x40>;
-- 
2.34.1


