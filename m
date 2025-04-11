Return-Path: <linux-pwm+bounces-5464-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1443A868F6
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC98D8C1EFC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2829DB60;
	Fri, 11 Apr 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz+h3EAT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E670278E4D;
	Fri, 11 Apr 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411889; cv=none; b=C8e/rY1yGaWCZc+iqIJw56igHiIYXpBzXwJxxCIqjPGJKw56tkLXC9qWhPWIIYV0RjwbFZCr81IY6uDKnUxb32VMb7Oj3N4nbBXHDRjNHYq6ukC0O7yRGO0COPhN6Qyr0j97O/386N09ykw95sBAMb4uBxbOYgA3EGtSzGqRKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411889; c=relaxed/simple;
	bh=H2dEAfc/t00J965VIE7MUieNVqutIi14syjh4T7cAUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd5V22/Iwa8mItXLz3HrRR7OdRCJjWKrUmJuyi/7roAKAnfEKsARtQLBL+yFRHVWO/cp4cMT3zJAmU46J/c8ynMVamPmaZyfeguNGmOV0sDEq5TA2R2xq4F3XhfN7DjmgnnlhqRO+M1TII0KALSsc0m8Od9YMIWXlMK4I7/7NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz+h3EAT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5a88b34a6so248758585a.3;
        Fri, 11 Apr 2025 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744411887; x=1745016687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEQDjb5KDxAGEAba9XLVOTbfFbTRrFjtfkQU13uIchk=;
        b=Sz+h3EATytu3fHbikd1op02c4MSCwZUQTSGJpmnAYYGJEPelm5/tmDdXNdqk8xoDY+
         s7y6zKSo+nfwMYfTQzYynixd6TZhsnb0zgovvaD/B95puf9TAdjId2ifA3k2uZbHDOWk
         Dtb3m4fr/pXSTtXpgivRV5Niz5lQuF1zQj6xZpEvNC6x2TckycQcfr14ZGTkTKYUjH8v
         /TGCNWXwIv7hvHOZfJKoI7oFmYGVPuGnNMomssmCGEswxl6u64W2YkwckivyveMS5wX7
         LyYRTTcSRBwW+q7yDoTTuxS1XtOnf0DhyYe5bWbJMuv33uQs+S4EC4IKFWJPx6QMDKQi
         y5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744411887; x=1745016687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEQDjb5KDxAGEAba9XLVOTbfFbTRrFjtfkQU13uIchk=;
        b=fSb8Wh8w13R6Eo1FNRu3Wg5ksqSq5xW99blFMJVoS4nLSvFQavr46sVoZcyRrLGxa1
         mrlgDiuHYMaRiXS/jGa7c3/dao8Pn+BUjU2VVufkkcTM63B/5EvtQsFhxYZ+lmY+Kioc
         O01ZP4MeaPY311ta+yi+P6pxQUtZO+5HwIPBeO967yH4bF+YkOTmGi53iA16d+2Igwfq
         HVMvnXNfKz2j0lMzeQgfXMoQEOmxo7qhd7OOg5by/r8rPzS47yQyRCo6+AUE85DvJG20
         0Kspvx44EXbCvs54QpSLq6QUXm7zWxsK+S9GE8HO1zOTnjXip0lPT667rMXsCF1l3Jjm
         eajg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFQJl3KP/e4mLum+/KB0pEOFO41oDaCelNpNAK3coz/Kh4dvFuhEPmUQlU8xATWPQUbOHbxG9JtSL@vger.kernel.org, AJvYcCWxbGu7CHGDYXJEAVGb/RE0Z1rbnHneIWNwP4dvhTZN7ZXD9Dkgs+VF5KSQ9j8/bkQK1iwNfSeRQu0k@vger.kernel.org, AJvYcCX5+kzyfQm6RubND3vYhQvC3+g8ebQd9HX0hHKe/uB5oIwfyYxo6v/pb4TNL4EbvcPN97MVH2+FoN32u4v+@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxKCdCxul32ygepp8dBTaxQdM1UfmOAxgIcu1rMdGab18OwpA
	MQP4WNk660EvaQheQ02s2U8eR1LbnYjvYRakIHJZXyGlAs876v29
X-Gm-Gg: ASbGncu/Q0yHovgVmlBE2n2QpiCr/fOj5XWI7GFivCpXyPIoX+4hTbqOCBtl9r+FPOY
	OpXoqBmTAp8fNPmD6MuCzYQEChlmUlLCC6ZlsXL/T61EtzKvjL/sx+Bd4A4fLmaWOcmqt8GGBrq
	0vCq+ZMPqod7iFbpLeeAUqgIrbJw2L3sQVsTFU5V/noRm4uNNv54164qOo5532wSxNz2zaT0VqP
	zRDb45KS6QLSfFMqLR6lfGTje+Zq8WRSKISZPbOjso/UWoS+KgK27TlGNdpJYHPQZWLmrqziCsG
	Ew3f0N/KbUtVBGaP
X-Google-Smtp-Source: AGHT+IGuYAfAK/ysb3ONfMtlfqBs3eOj3RFMg0gm7baoEe6QDUIz8+Gcn1rGlG9Y2X1CtFTB7l/gCw==
X-Received: by 2002:a05:620a:4399:b0:7c5:6396:f161 with SMTP id af79cd13be357-7c7af20ba80mr809021285a.49.1744411886951;
        Fri, 11 Apr 2025 15:51:26 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a895181csm322699285a.32.2025.04.11.15.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:51:26 -0700 (PDT)
Date: Sat, 12 Apr 2025 06:50:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr
Cc: elder@riscstar.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Subject: Re: [PATCH 6/9] riscv: dts: spacemit: Add pinctrl configurations for
 PWM0-PWM19
Message-ID: <ujkfb3ajvoebrkvoepztgh3afzw5dq7djefvdddiboo5gxu63x@dlflpzwpv26u>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-7-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-7-guodong@riscstar.com>

On Fri, Apr 11, 2025 at 09:14:20PM +0800, Guodong Xu wrote:
> Add pinctrl configurations for PWM0 to PWM19 in the SpacemiT K1
> device tree source file. Each PWM instance is assigned multiple
> pinmux configurations corresponding to different GPIOs and
> function modes.
> 
> Configurations include:
> - Mapping GPIOs to appropriate pinctrl nodes for PWM functionality
> - Specifying bias-pull-up and drive-strength attributes
> 
> These updates ensure proper pin multiplexing and drive strength
> settings for PWM signals on the SpacemiT K1 SoC when selected.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 315 +++++++++++++++++++
>  1 file changed, 315 insertions(+)
> 

I think this is too much, I think it is necessary to leave
already used one.

Regards,
Inochi

