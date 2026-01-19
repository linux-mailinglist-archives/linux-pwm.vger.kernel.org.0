Return-Path: <linux-pwm+bounces-7919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A9D39CA0
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C64830011AF
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4E235BE2;
	Mon, 19 Jan 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFMZR/HJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D311E5B70
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791340; cv=none; b=EKKJHA8oInROFUJXYAHFlDroF0KIyryAjlQePLMhRzHefhabcwLwJ8wjbVi/CBrxOPKhUiXKJaFobvRRHVRwIpNOGdNpu+JAvMzJwD7J6UHbEBm1LgMQK6MRZj0JVIbjx/5env2VFCPniUnXYRV9EoKqIrCxd4Y6qNOhfNOLXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791340; c=relaxed/simple;
	bh=JISZLytz4Pt6Fme8H2Z+L3YsYrinkK3R852fMWxaq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1gBVtIIrG7jQRaG16fMmOhtKvIp3WcUYaeovkYkrq7R2Uw3JbupTdJSbX5/XP9XnRkfjDXXTDUPsFv7kIOM/MFUlvY6v1D6UTicVsP4RdTLmae95wfpTzzHmOcAX5HIFFDCaaiH5cDYuZNgqH6exwXBxU0Xhw42bp8JI2Fcxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFMZR/HJ; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12336f33098so2727262c88.0
        for <linux-pwm@vger.kernel.org>; Sun, 18 Jan 2026 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768791338; x=1769396138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBu6D8bYwlSbhTzZMxyYo+wT+D+xqFcl/ZzNREhx89Y=;
        b=KFMZR/HJvRlEfqhG7h706d6Ggs2XlOiqmvwTmC3qXW5WOGPRT0wnKZiGx4uR2ec7dU
         1/rDZufWvFJvK63Fr5KFMFAJYGK8t3RRA2Jy6k66oCWmLkFZzPcHh/qUSfwBN8/PbNy1
         BBlf7nHyFBnyRz4y/KbziknFkwd+fwT7969/rDSqYMgbS8RtrIFcuOGeTwsV31rUBK88
         DoTf7WDzL3tGmYEEauMLsQnswSyVxnleNXb7oTOQwJTqaahBU1IgmO17krmJ1vviAaiW
         KycdC8eEn9YGdWNZXOuTIMEz/IadqFH/eeouo+383YJzx69k72e/ouyRue694F/YVt6P
         oxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768791338; x=1769396138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBu6D8bYwlSbhTzZMxyYo+wT+D+xqFcl/ZzNREhx89Y=;
        b=JZd36rt11uyIaACcKCWsIVESW7c9CZfw6+yYoAigTIh8gRTIBaUOby0nTbFiN0pWq9
         OCzFvoodrwpCTx5I9Hi0+qaZpLYc0B2tLBwfQTYGOjzn5PdP/mfEg6qeJb584FWY6Kr9
         VIo54OsMWpG42t0nd1tdmCCUIrXXNT3sVDJ0yjwJp+HpF1NQ2SflrrmnT1OLD0wk5o4U
         BtrQ20R2INNG151SpKJfuVe/qxzhP7lfmPnaozlfVbPtKqgAAX3lR2BDKFkNTWjPV7+w
         DQdHPSI01MyS6YADJb9TO39/HzTPr6r/6ytyVWB3sjPk7q0zAw9WvaC9R3DDzwguvvvo
         pLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVLz7gIiXKv/H4ejafasSRSnfGml0CfeRS6FE7CXUT0PAeejsP/bf7HkJdm/fBt+F3GLRSSuVVPnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyfNDo2LyY4OTWXkmv9uPNUfR1tbHpi53UbDG5JX64cXxHUhs
	iIkTZOCH8FaxUD2IbVEP1vzMHMWqaYAtxj1JDE7048SCMUusevhy9Rrs
X-Gm-Gg: AY/fxX44RWQ5MR2Fh2oLUkaQ69dzkCX2djCWB9HjeIIAi9lHDfeTmvl3rYOrWUjZz86
	8kIl3yZ6+91m9glOUuwpqXS7AMqPoPvPwIrpHirX1wneAwP7PzImuhvOJthPx/U5Wn4YFjk8pVt
	OYsI8CZ3XejtQOBEgqIXHw/o5JODb1vU+6tciVbI2/Q5ZrbOF1EulfCREUbO1BOuSV8FTQvkfkH
	UCZ1bfmQKszW91Brwd4i5ETwDogzY/v2ukdOdEsXwqZNXDyIDuu5AmW/joUZyqo+/JY56uFtejE
	6ooy6U5pUqp+bSlg/pbM/V3cPAALtvOA2fYknuP4Rep78717vzDiRwlO0+VfpHg7hw/Iuh5lPRb
	8LeTg6ZZBeiGSwDbnkMljrwQMOPe+Gei56ORiB1CCnXOGw5boqYmh5emyF2VPZnzZTcU++/Uo2/
	sSA+fgFcnNq2mN1f0zBGXF7XT50I47SliFmQKS2z6O+ot5R789z+cVuqrIN1o0b6v/TnUXxTJXf
	4L5c4tf1NYMhFC5OsF5bNyZkRSK8Mmaun6X/A==
X-Received: by 2002:a05:7022:b8f:b0:11d:fc4a:c4f7 with SMTP id a92af1059eb24-1244b307e3fmr7398972c88.4.1768791337890;
        Sun, 18 Jan 2026 18:55:37 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3696f40sm11100722eec.35.2026.01.18.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:55:37 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: g-praveen@ti.com,
	j-keerthy@ti.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	n-francis@ti.com,
	rafael.v.volkmer@gmail.com,
	u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting configuration
Date: Sun, 18 Jan 2026 23:55:04 -0300
Message-ID: <20260119025521.26212-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
References: <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Uwe, Gokul,=0D
=0D
Sorry for the late response, I was on vacation and away from my setup.=0D
=0D
On Fri, 9 Jan 2026 23:53:22 +0100, Uwe Kleine-K=C3=B6nig wrote:=0D
> That makes me think the problem isn't understood well yet and needs more=
=0D
> research. @Rafael, does the problem reproduce for you with Gokul's=0D
> recipe? (Or did you try that already? I understood your reply as "I=0D
> didn't encounter the issue but also didn't test specifically for that.")=
=0D
=0D
Right, my previous reply meant I hadn't explicitly targeted this issue yet.=
=0D
I have now re-tested using Gokul's sysfs configuration sequence, but I stil=
l=0D
cannot reproduce it on my setup.=0D
=0D
> As I cannot reproduce the issue, can you please check if adding=0D
>=0D
>       pm_runtime_get_sync(pwmchip_parent(chip));=0D
>=0D
> to the probe function makes the problem disappear? Also please boot with=
=0D
>=0D
>       trace_event=3Dpwm=0D
>=0D
> on the command line and provide the content of=0D
> /sys/kernel/debug/tracing/trace after reproducing the problem.=0D
=0D
Since I cannot reproduce the issue here, I can't validate whether adding=0D
pm_runtime_get_sync() changes the behavior, and I don't have a failing=0D
trace to share.=0D
=0D
For reference, I ran the tests on an AM62P EVM using TI's default SDK=0D
userspace, with a custom kernel on top, and U-Boot from the SDK. The=0D
board was booted from SD card.=0D
=0D
I used pwm1 instead of pwm0, since the PWM pin routed to the EVM 40-pin=0D
header is ball B21 (SPI0_CLK / EHRPWM1_A). The signal was verified with a=0D
logic analyzer at 24 MHz sampling rate.=0D
=0D
This makes me suspect the behavior Gokul observed might depend on another=0D
configuration interacting in parallel.=0D
=0D
If possible, could Gokul try the same recipe on an AM62 EVM using TI's=0D
default images and confirm whether the issue reproduces there? That is the=
=0D
platform I am currently working with. This should either match the AM62P=0D
results or help identify a relevant configuration difference.=0D
=0D
Best regards,=0D
Rafael V. Volkmer=0D

