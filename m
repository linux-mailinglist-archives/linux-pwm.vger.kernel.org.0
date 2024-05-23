Return-Path: <linux-pwm+bounces-2227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB81C8CCBC4
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 07:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8065282952
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C612B16A;
	Thu, 23 May 2024 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igXWT9qQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4B2135A;
	Thu, 23 May 2024 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442245; cv=none; b=NzH7RE/+ssQCn+wHt90spe0HM7mKhriQ+wyicIJGWIQe/yvSV6ZAV0IBSHtPjqST4V51BZOkn9qLSGQDdGrhBsrk1+BxbFKBwc9XxK2LUxrIxsa5gQ8dZ+pkkJpEgm54l+XD31RLBCdMtJQxBR2wSjfflJxFcGuTS0okJdabTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442245; c=relaxed/simple;
	bh=jeP04vuCdyKqyKQziTj/qCMLaFBjvVxkxdMxPwwYkVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bl5FNZkgKACwJeQ/ZwUrNR1Qhi+21ZL5kfDZdm93BKokBDeulCma4K8EbEJsJ06oGg8RT+TneNb+ISZi3NK9TwW87EHw1FgomGhGnDpRwYQUrhAmDmvg/g3iyBYKCxGWv81HyyBW97py6HQh+gd0k/hOvWA4F17GyybeV8urM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igXWT9qQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4e81e0b22so1393949276.3;
        Wed, 22 May 2024 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716442243; x=1717047043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jeP04vuCdyKqyKQziTj/qCMLaFBjvVxkxdMxPwwYkVA=;
        b=igXWT9qQBj0wFQvlEprq+SigJa3T2kYX3nVptrK8jqDvHDH35AONArPczEZPp9Z2nB
         vlYv9X6ypZlqryDL6RoM7EHCwsNgbAbuKIngzrX7N4P9nHuC2ZBf5rd5mQ8N9wZWH6Qb
         j5rkjm7XJzWC4vfZnULSG2KV0oWa9uXw48sztBsulcI1FWmm5F4NTbQZWFb5BR/jd+Wx
         wWhcebIcosgzta0faFqS/KNVaZPzcKQEl0oYMU6gHhx7yGKR/QRwRk4xLMnKH+Ln5HUA
         f4lcHiPj/z8vla0pwbivJuyry5vHTTJ1rxSX8YpdCEtNQ4ZjOs5JcUIWeJoQ5S9eeV55
         UY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716442243; x=1717047043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeP04vuCdyKqyKQziTj/qCMLaFBjvVxkxdMxPwwYkVA=;
        b=nfI7keX4jBbUQGFMZAT7wtmAOZCoEQjDd54yWEtC4Ki1erpns8hfznvF00ab1XjIAP
         XCclDzpssIxpJcMqr6I2pQpx+gI27Sb3Y8FyolJt+44gbQbGDU+UAyQVCW9q+VlEua0c
         SaOSo+9/a2kqaTM69tNbn+FKFqJ0L7KxiGh/akQcNiYskjrafT2EKDypIoCknSJqp6SX
         l4szPt+wRRb+0RT6aHFOs5EYI+BPn0xzEKZIBlgfGUP4kEjfdhLmk2UCfTB7CcrOjWlI
         S5YBp0lkYqUDJlBM458wzB4xNXnLxi7uC34p0PKhqf6slzm1QbPj607e8WFrcftFj5d2
         tNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVflYGuA5J8RUF3mqLwbqhWpKx8N73LxUkSgoYjc2e9YyrJ52dWY7xEvaMzQQmp5lxjFTKpM/r9i6Qn990chNFQxpXJaggYCLMBEBDebUYbpVC1d6dVq2A0lrM1kFSPMQr+NzIRaHYRUdOq5lm7+FYImqTCeXpcI6uwPE1fe1naK3zxBw==
X-Gm-Message-State: AOJu0YwJHw0iHKyWAVYIpd05bllYgUzBhJ2u6jWQNPyGB6gneQ4tdUdv
	CW8zOEGgsMJkgSbJX0qwXBn8VIZ20Y065mmDzslG/7/Dt048Hvn2cC7WRX5/tDSjoTCK0auD8qP
	z1Dg+VkeZoU1RMqrNNo7II040LsI=
X-Google-Smtp-Source: AGHT+IFwNmf9mikTsRKBvOMdbJUka1g4+AANDd7/jGjpPbZNh3NDCKIMRlgEx8AomEr4C5opC2T3EcB9FDNaZkHjtF8=
X-Received: by 2002:a25:a347:0:b0:de5:5510:1d4a with SMTP id
 3f1490d57ef6-df4e0be4b93mr3401384276.34.1716442243001; Wed, 22 May 2024
 22:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
 <Zk6yK3U9tgxOxcBb@titan>
In-Reply-To: <Zk6yK3U9tgxOxcBb@titan>
From: =?UTF-8?B?44GN44GP44Gh44KD44KT44GV44KT?= <kikuchan98@gmail.com>
Date: Thu, 23 May 2024 14:30:32 +0900
Message-ID: <CAG40kxFxE_Oj+9aCzGku0a3KFHpuW8ai=gEkV9M8==5gwmjdEA@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
To: John Watts <contact@jookia.org>
Cc: privatesub2@gmail.com, aou@eecs.berkeley.edu, bigunclemax@gmail.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, fusibrandon13@gmail.com, 
	jernej.skrabec@gmail.com, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, mkl@pengutronix.de, p.zabel@pengutronix.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	samuel@sholland.org, ukleinek@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

Hello John,

Your method is quite impressive and challenging.

I think PWM is not only for LCD backlighting, but also for signal generation.
For instance, imagine an application software that sends a stream to
one PWM channel to synthesize sound by changing its period (plays a
square wave).
By your method, if the other PWM channel is used for LCD backlighting,
it may flicker repeatedly on DIV_M changes.
(Or simply both channels for streo sound synthesize, you may hear lots
of pop noise)

It means the setting of one channel can affect the other, which users
may not anticipate.

Best regards,
kikuchan.

