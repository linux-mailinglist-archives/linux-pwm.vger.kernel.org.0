Return-Path: <linux-pwm+bounces-3668-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90399FD0F
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 02:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9CF1C24292
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE96AAD;
	Wed, 16 Oct 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6tu7ny5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5021E3CD;
	Wed, 16 Oct 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038050; cv=none; b=jsCg1Qv7HpRsxolxyrrk0mHHeDWbFpbNeGQaHYr/JunhRgvHkvPcsZkKttBex8YqzxE9Css0XiUHLSZLbY9w1ZNXscP7vG6f3rF0xb/oKRGt7IM1FHrssZKjvpziabNTAWvao31Z98Yu+mvVqDlKQOIaAX1HAYzrUauyjZX6iSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038050; c=relaxed/simple;
	bh=kuKctZJOjS2OUZaqeOyTGjg/MdoY3xFfnNR1RUfMJ0M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdyK2pvGZhDvEZEWlgZ6mzBZ8wMrJvmxUa/Thz/IEjsCiRzwBce9jV13poSvO1fHflxUZvfSB+pEgjnHg9lGViZGG8WFoFBE8OvruazNeflLV5Lbrj2xGoEnDDQl7eQAUO0upspACFMaNP1/mfMDUU4I3EZI54nZGwMPd3qHSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6tu7ny5; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277e6002b7dso1712224fac.1;
        Tue, 15 Oct 2024 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729038048; x=1729642848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVj0JZ+cVfOjaLAf/i9q4f7a0NWdixO3jwQiTDHespQ=;
        b=b6tu7ny5Hgpq1AAx/3orRn+Hbw12QPBwSxfogUVOkm3MgHJYmuqugXBUPfnH++hkhz
         euuWHYaCwG1+ykzecLn1fkTSTLCKbCKQVARJ4DpUj5By4udwGZR3j6ceG8f7H4m2nmh3
         yKe3hG8+XSqzz/R8hx4ZcIuYu+m6asNAImOAlvz4S/XfOf02THpZcT5w+nhzSTTQbFer
         6PCTjEniHeWCdTdM5JFY6KSJuOnGGcWidd/KEHrLkgM0x6uPy7rTKRUgO8Y0hR85kYwz
         zbDlafcKGd8XRgRhDRB8AR7LK6iY0zlp7BSfzT+A2rs3N+cgOfSrGZEvxyPcxA4BnahW
         umow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729038048; x=1729642848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVj0JZ+cVfOjaLAf/i9q4f7a0NWdixO3jwQiTDHespQ=;
        b=iQyTwaADcfOi2Shl9YsLwUs3PZTGL0Qf62uvxMeGBphmxje//sG5erh9Xbu+ZHWDi9
         CDEqFJrcl1KSilSga1kcoFSd4LYHCfUqN17vjFecdvMnjJnBFDehsU6QJZcHXE4kxxAf
         uAMHyJYDCMTIcJmsbhSwxff8szPYOmC3Mptj10/8lAu8gPHkPuERA8IqFdxfu9puq/6V
         nEgnJ36sPnMNM9coF0LLrXSWYjLfflXKMuDEfECtfXhNUN8GDKseDHX0Lmr/swLIU9aS
         b2ev06DwMX1vWx4MKWVjQEYSGTCDdZ/7XiToRmIgqU4wRlZBtHQlm8+UNE0ni59pqVTL
         YVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvhgpbzcNtCnFYu9XSSnFT/B4A2at9CaP3FmCAcKQCjyLMelL8vwecWDV3XBJ8mekscqgQ7olfR8U@vger.kernel.org, AJvYcCWWCXeagzDoYTtV/+slmfrKTQJ4wVfI1Zj+gu+PFAoYi0E4fVmfanRmvWJFqIUfJZw5V2FcmVqsiT/e2mGb@vger.kernel.org, AJvYcCXDIIctEjx9VIHjYDam+cIaaVQlPnYx3Gh8jMYwfz3pMI79QL+WDLA9I6JmmkNgqm+/x98Ac4KIKUsM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki26XjEO3ejMcKeJM2DqksybXsfmwtrYt8+SG4vvtWNNZgN3l
	Siyiwh2DeCXgsAAmAIB8/GVAe3//L/nmp59EDQJ/S5I1LlXdU3pa
X-Google-Smtp-Source: AGHT+IHvf7ouPtaSG82xKb3eFmMLOpPLuTSfsOfTvP7DU8b6q07TaVWaTqCFDJB3CQRdG09P+SIIXg==
X-Received: by 2002:a05:6870:a692:b0:286:f24f:c231 with SMTP id 586e51a60fabf-28887376bfcmr7450243fac.25.1729038047659;
        Tue, 15 Oct 2024 17:20:47 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-288dab8a172sm623857fac.6.2024.10.15.17.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:20:47 -0700 (PDT)
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
Subject: [PATCH v4 3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
Date: Wed, 16 Oct 2024 08:20:40 +0800
Message-Id: <56550a6c9ba94c170d32b1f7c076b6faee42ae9f.1729037302.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729037302.git.unicorn_wang@outlook.com>
References: <cover.1729037302.git.unicorn_wang@outlook.com>
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


