Return-Path: <linux-pwm+bounces-7713-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88675C90714
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9431134DC96
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104B22B8B6;
	Fri, 28 Nov 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU2TJw3s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79521D011
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290344; cv=none; b=kA0c1eEX++mQWcl7RnBrlzw6MnQg4khycDZ6zsaPbWSE07arAy/2t9PqjF2/ERoEGoRyy07GseG9JMbxOsY78hbEDjA+Q9DTWRX4DC2l3spevAd51qT9imV49cwUEi5DrGEhunZ7T7U2Lr2fl24QyeIBiec1nCADucM3Yn38Knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290344; c=relaxed/simple;
	bh=XcYxuRkbMSMmuYTP8YMtFe+YyYOjM9ZCAbhwFZWTHDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9+WSPyabm6AOgt2Hah2Ae7HA8vdAcvxw6OXFQsBUbOxVVXZUenZ/dxntTbZ9L4TSWltmfdZ4uJ3Or8KbeMsP1W89DJLeEWuYF1zVtbLITdLXJABfiC5Yon+5ggz3VXTcQKKAu9LpdIPyXZt46dlmN0ewqeqbuquVqyubJ6oJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU2TJw3s; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso1014173b3a.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290341; x=1764895141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m55KX3612XXkHw/M8fDHwtC9cUcyqT3pIXf0q1wbKI=;
        b=dU2TJw3srcBY4QTSMsy4bOUbZU3UjzqtrGa1RJFlCUPXJMNbKtCiGnYFq5H22spjG5
         2wX6McH/wPxDDbQzmTaZFs+a169vTpFJ85w1xQ03a3i3QMs/WHFjVhb4+zbUo5CeJcQE
         VygnLbOKVXSszTkPUCQw0kSY8p9j31R9cpRzOGQVxzIS6c1fwQTG2UXixIe7XSy2fQaQ
         xWmV6QnXu+zcTKU80HN3s3hhUnYgLhuM3b78+YzUWoCquY0RkJwTktc+zX1ZjLzVIxq0
         l1RgZO4weFM14+bf+kKSfNJHHM4/ohTSrck22LMz6Pw5Nfu1KF/N6NbRYfU4TWwI9dHj
         ozRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290341; x=1764895141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3m55KX3612XXkHw/M8fDHwtC9cUcyqT3pIXf0q1wbKI=;
        b=M2DSP+3wEJegYBDGzjLA3bfr5s8TwCRf9fmz+3kKaNZWDV0V/0XmRARIl9yXnpixEM
         OfGDp5tNDy5Shi0YGFVmki6/3aLvpczzEg4Qk0kEtSzj2cxe2zgNd59CiMZgBIqsgLlC
         wgUEc4IOYp6K2zIaTLQdKpQ0ORz67IfslxrkSzoW+bNHdbWUQFy29MsBkCD0FheXF3HO
         Lifc5OLbS+tgJhUFbQ3Th4VAyvWyFbqoAsAhcgYcHU9P3xwmsUYAFQmi/Aw0BXi/ZTHt
         QZHyGpZN8336PDMFCO4Qbz/XCKrtyGDydTbxwFwCDcPQX7lNMMJSYeTeh4apx6F8GT8w
         P6CA==
X-Forwarded-Encrypted: i=1; AJvYcCVi7r0N7OFvHVSjbsMcRJOcR4MFMKItuzL7yQ40JNYV/zDcst0RpV3x0BRo0vnrNIbhopOd8PWPN7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTNQVSFvkbhYAc7ZPbDWC9cki96HAjQI6BhSC4jkEigRL11qQ
	TQwlIQqeHp0elVncHSPyBb0RwA17UM7vhZaMt2wiuGIwFj4kNB/LefPw
X-Gm-Gg: ASbGncshypiy2N/kNnmhMwsRHAQA76i8tu1CX7XZGSIu+kaEK5fSV1oVIdug7Fo210E
	c7YmSEdy5q/5WJtTRZ5rbOpY/Dl7znOezYFQtQ7iLanFYiYtfGJ7nZ1YiONOiSramMzhF47mouG
	gKuBznE07/Re4K6E2DNisweay0yb64TiePol+KCizVFzlzTBR3Dqdt0QI6kuIPnMD/6dnrENawz
	T4cJA0DmHv/rn8kN7p1hJAEyjyNkVkuHyMsTHhKQvIm7Hp98pKgHO37e5Cq9a/1BEloU2NHcn1i
	HyC6B5G0zWnYmpK5lAJ/umsvFd14rU/P/6/raRjH6Dzb/+MQTWN+PyZUVyoNXLiC9ebT92oPqBK
	oxpsTd7eJVck2vUHnwjm4nOi5tbXO6bWfM+dt89hBzPvBzBvyiYug02NvUFc3tWlDI9suOxEcB7
	E4QA0LmYSEgNmYLN4awJGbMnFSO8Eva9rKRf9eXm9tlc4=
X-Google-Smtp-Source: AGHT+IGC4C2OgJTsiIUdA0q3wwE6Lz47PE6qPSYvxBvdGl77cHEpD66qLHgLZop5EYDl/xrIDZ2zcQ==
X-Received: by 2002:a05:7022:e803:b0:11b:8b4b:bff7 with SMTP id a92af1059eb24-11cbba71950mr9482927c88.39.1764290340780;
        Thu, 27 Nov 2025 16:39:00 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:00 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 4/9] pwm: tiehrpwm: derive PERIOD_MAX from TBPRD field
Date: Thu, 27 Nov 2025 21:36:29 -0300
Message-ID: <20251128003634.247529-5-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded PERIOD_MAX constant (0x10000) with a definition
derived from the TBPRD field layout. Introduce TIEHRPWM_TBPRD_TBPRD to
describe the 16-bit TBPRD field and compute TIEHRPWM_PERIOD_MAX as
FIELD_MAX(TIEHRPWM_TBPRD_TBPRD) + 1.

This keeps the effective upper bound unchanged while tying it directly
to the hardware register layout instead of a hard-coded literal.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0802f0553587..4b8b4a9e7379 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -38,7 +38,9 @@
 
 #define TIEHRPWM_CLKDIV_MAX			7
 #define TIEHRPWM_HSPCLKDIV_MAX			7
-#define TIEHRPWM_PERIOD_MAX			0x10000
+
+#define TIEHRPWM_TBPRD_TBPRD			GENMASK(15, 0)
+#define TIEHRPWM_PERIOD_MAX			(FIELD_MAX(TIEHRPWM_TBPRD_TBPRD) + 1)
 
 /* compare module registers */
 #define TIEHRPWM_CMPA				0x12
-- 
2.43.0


