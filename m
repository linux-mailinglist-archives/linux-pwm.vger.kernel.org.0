Return-Path: <linux-pwm+bounces-6330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C59AD795C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D629C17AF79
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5056929C33D;
	Thu, 12 Jun 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="1w6eSTYw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BE1EF09B
	for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750583; cv=none; b=K05jWcQ91hpvIntObHSaA7MdzkVY/rCi5FR8QunCpMOGvki+XRSq4b4plhbcDgJNbCF5AIAWvB9fkJBH01/2+zXT0iP9vLOOZ9Xvsogpl8z2NpIUomKpKgjXuoV1BYjJD9t7gfQlPFunlOK/rBX4P3+deOahmFTgWIaznVOO1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750583; c=relaxed/simple;
	bh=bdOP/dpPl/UU10GsQOaLEBHx9DtJHd4giISmHR0qzJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob0LjKKa6aDutl2oTtzh2LrmuOlb/6Fk4YrHTx0Ie/LmUaaVJf3waDLgHGcECGcLq8uy0edV09j22lz/8bvFYsqt0kpNuEy+tScwm0YjpIVI9nohRfkrH9pO1btjM805iiHKDwCyHXNLu82ZZ1imWZcpb2cKlQGNO1kQDXS565s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=1w6eSTYw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7482377b086so876783b3a.1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1749750581; x=1750355381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kKudhM6GP7ucCr8LJ/xGTzdQhmTfuZa6CNBowxM0Kt8=;
        b=1w6eSTYwQvXrJY/0WPcquBS4DdRzRTQpxxUCCO+W4G1dFRCmLqRj/Er48RRbHWKqtP
         8Ax2OzIAjbH0qcmENWxE4eqg9b1/MzZmDMU8ahfxIFXBb0RDtVMuD5d6UXwzueoMWb1n
         qqd3xoau/DNHSYV+7JEfbPPfoW2/hWGEiZaP97GSJNGmpZJp0x0v2ZJCHpqmQF/GYMxn
         6Sn5b1a7DxDKAzMX8ckrIKTeIAmAgK8LrLsVNdFgu3tUAgplHMJG3cvTOKG4soriqlVu
         w9iUeXl4FlGW8obhTJzteIfyWO/Py78ULzaNmGT9aZhMa6HzxEKCpR//fzz5xGjlyry6
         S1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749750581; x=1750355381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKudhM6GP7ucCr8LJ/xGTzdQhmTfuZa6CNBowxM0Kt8=;
        b=vYKJ3euM1y17DwZ0oD/Zd1R+70xqHjKlQK/lP+goPuYbTZheuuJAoNfddcQI6/JuBi
         sIaBkb/Om+nXmLUbaOtENSxFHOj5H2S0S0P8sstAl8yJG4XJKqLS0X+Jy7K5QvcmQU16
         Nn9TSu6+JmR7ehCym4j0p+mZCAOWIeDj4zoQY4pWRPnasqaiwKucGpjaCuXb3PODjYyJ
         EAcZvip+j17n685vTA0RfKOzPnyjMseqFTlTkbincO0+4RqhrTzyWw+WWqYxRIM3F1pv
         CrE7Dk9Xuv/FapbQfe+fOnl76XSh01i5bKCLeFnkuTe7GXIOHJwzMj+ZM/SK98c/5Sxc
         IgWw==
X-Forwarded-Encrypted: i=1; AJvYcCUFP8fun60Un2WpOaXEQfNP17gFL8PmtQvLCOF/wDIGTJVWMFGFUl4uDGc2oKdXAjLa5BJ8YOorJcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslzhxiHyNOQve3lVhJDVCKF1EKkRpUjp8g6WfljEzV8CjE1ym
	ZA5vDSm43ib7FjZzhlXyqjTdj/xC6tPCW/IPbFnL0CnpbRJ117isCAJ5VY/75n1FTvk=
X-Gm-Gg: ASbGncs0dVrN079Urvj9zbG12dhOiMRqOedp1OugxBRKa/GwrPSYvyEDKm+41mHn9PQ
	p/Cc8pvMvNMPY67St2w6aqdNXWmFTcsDMp43DYdtzGmVRIawuld6jigQ9tI8EtCf6Oq0XSqnlAT
	QhaTOq41NbPw4Fncu9dNjOh6oyU9xZZ/ntAN6nuWKgX+4P2g5Xef4DP9eIVu+m6zOuL5XNDB5cb
	kw6FejSoXXplp32+anfwvz628L2J6dDXCm5SPDxmdQq0MrpgmtB0xQasO0YVu8BTMGLL+pyPllt
	t36xDWVoZ3SGCV+mPxT1SjV/UjuPPH93hjSQeK7/rhQeYxdMzHYW23SKCkErV2rkLNxEtCXeSQ=
	=
X-Google-Smtp-Source: AGHT+IHLquFrw79+co4boFO8pJOfM9btk60nayGRQuNX/0ZumrQqIBCAkSYORT1Ip62N3F8udvKXLg==
X-Received: by 2002:a05:6a00:984:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-7488f6cb9b2mr295006b3a.8.1749750581050;
        Thu, 12 Jun 2025 10:49:41 -0700 (PDT)
Received: from x1 (97-120-245-201.ptld.qwest.net. [97.120.245.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809eb146sm1837808b3a.109.2025.06.12.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:49:40 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:49:38 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aEsTMrdmC7drMJIs@x1>
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <aEifXZnLxKd2wa0w@x1>
 <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
 <aEoWtviFl0vYATXe@x1>
 <t26bhukukjzy7e4d2omtvjchxxzlnfyx54ku7xbytcnxkuk7xk@6tap2t3z2oaq>
 <b3252042-e7fd-4ac9-a4ad-0226d21fd477@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3252042-e7fd-4ac9-a4ad-0226d21fd477@samsung.com>

On Thu, Jun 12, 2025 at 03:27:09PM +0200, Michal Wilczynski wrote:
> 
> 
> On 6/12/25 07:01, Uwe Kleine-König wrote:
> > Hello Drew,
> > 
> > On Wed, Jun 11, 2025 at 04:52:22PM -0700, Drew Fustini wrote:
> >> I also enabled the pwm fan driver. However, there is a probe failure:
> >>
> >> [    1.250921] pwm-fan pwm-fan: Failed to configure PWM: -524
> >> [    1.256546] pwm-fan pwm-fan: probe with driver pwm-fan failed with error -524
> > 
> > 524 = ENOTSUPP, so it seems the request had duty_offset > 0. Does your
> > fan use PWM_POLARITY_INVERTED? If so, try without that flag. If your fan
> > really needs an inverted PWM this of course makes fan control buggy.
> > With the next revision it should work fine (as a duty_offset > 0 should
> > get rounded down to 0).
> 
> Since we're running the same DT, the polarity shouldn't be inverted. I
> see you have CONFIG_PWM_DEBUG=y enabled, which is most likely the reason
> the probe fails.

Thanks, I've disabled that options and the probe completes okay. The fan
is now spinning :)

Drew

