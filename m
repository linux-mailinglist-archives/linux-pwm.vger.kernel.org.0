Return-Path: <linux-pwm+bounces-6142-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A51AC49C6
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF4D179773
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DC248F54;
	Tue, 27 May 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="03/rMuMk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C218DF80
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332817; cv=none; b=ib8hr7qHsPROKG9HaWoIYfKjJkyN7wofHZ1PX/AfdOIfgti5ezY7vdP6UQCvC/hhyrQvDExlRInZkd67jWMEvghT2YGNmGXkOJZpQTRiQzN+2L6Q1fPDgd31fyYPl90muI6sN2PYrGNcV5b/lfFhMdyqnbvy6LdbO5Th3URWtbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332817; c=relaxed/simple;
	bh=yEaq2AyzfgJ9c5t9b0CsXDMHvC/M3FL4KCVrex/8yZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAALiA0FIoUmn9xDzPl1PTGGNvry0ZuS2R3YYvTu9kU9Lj1YuMDaT+azkGoz+F3PijkBMKudY+EcisXilWq7CpHrQvgQPygKDRW1FNEMV268ftOQCZuPV3wK3v9UhvIWUfrgwiPau60Bh9r688a9JIff8mGRvohmeUBDmffc24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=03/rMuMk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2349f096605so3980605ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1748332814; x=1748937614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69mSzDBjctUjkk/D5FpImgqRo3X987asQpikl13S/kU=;
        b=03/rMuMkaDdOVPrReoSnbmzgy2uJlFpvD3OpfhqUU9FUrYb33BkA+1t7ZNHdKtpSPI
         LEQvO8/YaBxACDFaeVlvty8iJQE8Yblo6w+C+Su8NOuvWdOOs2vLxKASLI+V+7RT9epo
         zX7Rr3cVeGj0lF9lwqgORUGFXgOPJFhuKDcfrI6NODjpY7AeTXq4bh5aE256wngCmhGK
         8chNdap7Gbvqk0GlNzgi/dnfS4zXfb9V+XxwnRe/SokOufWEG1BYNQbXFJGR7FOI3RDb
         sy+pkoyygO+Z3ROCewBrylFyGJaWuJJCfyyEragTOOFYo7LM4kqRdSH8astQOqL7y+J6
         P18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332814; x=1748937614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69mSzDBjctUjkk/D5FpImgqRo3X987asQpikl13S/kU=;
        b=Ap0LRc2NrBkGj0qXmMcC7ClNN+C2AOc7enmSvJ2152MdA8eAc2/P9kskFZrmu1ksIE
         Dg5lQ+fevLLcVDYx7+b1ToQ50xGtTLeEnFwC5A2IFaZ4aeez+JleTSMrBUB9bK67vGma
         /8nnUJgL/XXhvEIZoF+ZFD0bE+Xq+PGsU+MWk+BoLhq+rSZPrpi9b2rKZxJB05OuV33K
         ml5t2g9x+3HV9lVEkkP0f5dwlQIl+tQU/Qg3Y5NKQw2WbOeIRnuoeP+4XmO//Q89si3e
         Qbkdm7c6/kzUrewQKqhhlcuVY7+kdnKgXbPcYxpa6lcssUAH+8GvtPRAfwZqEQGYb+Ie
         8I1w==
X-Forwarded-Encrypted: i=1; AJvYcCVpEyueLFmeuM5NtOFVOKptGZEmuuP3JaFbDzeDelZ1c3MTyGZct4lUOGJl8ter8QY3jnuRKCrlzGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69mtJx1HUBybMfJYNBER39LxQcjqHSkwP3UlkY/mT/EIHDKVr
	05tODxevHMXtymA3is+RsciBuTwxUQ1QQaZx7ENlgT8uCCG0B0CaXXm4enC1BleSVJ0=
X-Gm-Gg: ASbGncuCtnmC5yeYf8ObylZpFcQ4Gt59nI1QayH3LW4zgv7cEPyzav04h3kBHwLippx
	jfIQFsYZuXSHfgmdvSB/wo9gEpTuRhEPmg0Afo2mePWxqqh3dSyzTc4MjnjiF03Ds8TQKx9TwrZ
	+MRJQ0h2hkcDjllgidoXbmupk3gCzMwLpcpy2WeoocifySExS+tManKNFRtd2iQL8Rrvh/1XR3i
	PD9Rq0wo4YXBwWcvxPMW+phfa9gx2Utr8aiURiYKAQuaWkIaIma2/OlZC7brOVPumt+XJtEA8b2
	FbTVVYctAefVf2hY5PQv66U1m89VI4Oq4aw12OZnBowJKGSuIUS6hQA509I342x76y3ZVl2T2A=
	=
X-Google-Smtp-Source: AGHT+IG/9w9RYy8XeVSB35Aj2XQw0SQ1Z8HiupqD9XgJZnnAgEoB0hzA2HUmbCT1F6TH9+lzKYQesg==
X-Received: by 2002:a17:903:1a45:b0:224:23be:c569 with SMTP id d9443c01a7336-23414f80419mr226841935ad.22.1748332814563;
        Tue, 27 May 2025 01:00:14 -0700 (PDT)
Received: from x1 (97-120-251-212.ptld.qwest.net. [97.120.251.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233f8b2dc89sm65321825ad.114.2025.05.27.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:00:14 -0700 (PDT)
Date: Tue, 27 May 2025 01:00:12 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] riscv: dts: thead: Add PVT node
Message-ID: <aDVxDJi0KkWXiPCK@x1>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>

On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
> Add PVT DT node for thermal sensor.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>  			thead,pad-group = <1>;
>  		};
>  
> +		pvt: pvt@fffff4e000 {
> +			compatible = "moortec,mr75203";
> +			reg = <0xff 0xfff4e000 0x0 0x80>,
> +			      <0xff 0xfff4e080 0x0 0x100>,
> +			      <0xff 0xfff4e180 0x0 0x680>,
> +			      <0xff 0xfff4e800 0x0 0x600>;
> +			reg-names = "common", "ts", "pd", "vm";
> +			clocks = <&aonsys_clk>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		gpio@fffff52000 {
>  			compatible = "snps,dw-apb-gpio";
>  			reg = <0xff 0xfff52000 0x0 0x1000>;
> 
> -- 
> 2.34.1
> 

I found that on my lpi4a that boot while hang after applying this patch.
I think that it is related to clocks as boot finished okay when using
clk_ignore_unused on the kernel cmdline. Do you happen have that in your
kernel cmdline?

I need to investigate further to understand which clocks are causing the
problem.

Thanks,
Drew

