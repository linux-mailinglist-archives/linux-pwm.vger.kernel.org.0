Return-Path: <linux-pwm+bounces-6260-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B9AD136B
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65991687F2
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2319DFB4;
	Sun,  8 Jun 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="ubv0t9Ts"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3119D8BE
	for <linux-pwm@vger.kernel.org>; Sun,  8 Jun 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401891; cv=none; b=Un3BVHdHQ5dMkS/3+4p8sPnuAuXUMiA8x80frb7EHyAxhCABIbRgUGlR0DuvmSn7xm3/cw9IUglfWSov8bSFicdQdFfGwQFNBvSlSU2YVp7OMwT4Z5plMBoSImFkqw2EiI3kIlcxcSj0qA6Ywb8WjhJOhpbJJRb/IEubQpvigOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401891; c=relaxed/simple;
	bh=u4wQyLjJp+430rQ0oMLZAAtB4ucOgT4UzH6dUPzhvIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQvUvUBHA85CTx1HwrhXqQYWaczAyYNgkRSbFG1D0/UTBjBCDm/CuyX0c3N8zYpOLIKeFtyP3qZkmLhdVxtTwOl8o+JHV0uYj1baLV5TOLNSkcPSo/kZKkncfsO6mKQs1XyVvQvAxtXaseGs7ejXJQcrx/ab7BL6RoctDgJ3Iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=ubv0t9Ts; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9ea8d08so26896285ad.1
        for <linux-pwm@vger.kernel.org>; Sun, 08 Jun 2025 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1749401889; x=1750006689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuldK7MCvX30cQFzWuI0PzalznhEarc6NW9MP8uHyXE=;
        b=ubv0t9TsGF7bJ5L5UAGBLT7VVfzMwkPEMnxeVbIs7hUxjNkeyvA/nXZHIGBSWR1QXW
         RrpuBIdAVpulaKdt663KHjNI0k8k1x23mLTWtyZvk503HnaUsyIG4BNvdjSxKiuGixaY
         zhFy+sPmiCDbmZTU3qZmxIVHs5ULE29mroS/N8nc3fp80eZfwnnRxEnIe+rpAh1xyhUj
         OqIKuO1Iigagd7Ikd0LfyHYGORKNCFUjubUeMPyzjBwwrNyTT8aHn7EG5axb2LpnFwmN
         Rz4/0CKTeICF2HsIWcMzd8Ekpp13T5JmT3e9otw6k6j23UuPBY9ctO6yYzyjaYC5ayWh
         qnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401889; x=1750006689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuldK7MCvX30cQFzWuI0PzalznhEarc6NW9MP8uHyXE=;
        b=PPG89LtaavH8UkNydy4VQjoI9fAvFTLBxdXCetpguL20eTPjxvwhp3NGkUvW7HBOrk
         Vl1JeMk8mKlnD1r2qlcjjq1eAC9ACxf/Ijo/9ysjMFygibrUoqy62hy3nWQp8mmhhzoz
         KlSv8CGI2zbnuepa7VPw8HpLRFw8OLuUd8KLQ9eXhoh0OI3DhTEXZe6BIlUhluP2fzJr
         Rwxq918yNHp7Cl/0BIjcH09zI04ygzKr8bHyeintYChS7CXeOpezJAjCE9ZnHjnGFNpJ
         J3HoKR46ubszm6YNoYQrf4nm1/cwkGeRPl9HOuqJrFYR0hEfSl0M2/dhvR3y47xKF6c7
         UurA==
X-Forwarded-Encrypted: i=1; AJvYcCWXBdV78fTHnuXExO7S0+f4AZNH18TiPY6vMiY5BWiKrZsCXeV1hrzvQlbq+3DkQ4abbh6PwATrlQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzN0mBk11B3+7+805fl1to0zJxdYSj8dB2gAJhdujeikDufexW
	rTcCzBXof5D96ix2irnQSmXhsFmiol3elyTeAGYaWo8UscZa2FRdubdXwRAYwB58tmg=
X-Gm-Gg: ASbGncuPsC7ULiIahHHJSkvvWLcLw9S40dpUEGRavgfhwhg1chtf6Ss7oV2MO15xRNx
	jEE3yxyszx6fMn1jIEIgzRF9NVQBP7wSjHbY25s2dARgGNqWRWTW15OcJLeH+D+JAL+Wg2upUP9
	qXwZtXG1LWjVeMb3xnBlWRRR4qnd8QBIi4/LchdAW8hWdLxX7qW+oqIjU1NfGA9nAqiToOM/23E
	FAdXIj116wpSAkfiXwWTxNFZjKU97v5t04sFPCP5b4Ffx59wdYAin8CGngoTk41x4Y5s335lWvM
	TCslUJ/6zZTojaLjultGA2pvA3ne3M0t8K10D+p88GnDBhTWMAJ8fA==
X-Google-Smtp-Source: AGHT+IHP9TwOiQS18SeLvT6WZ+KAoJi7YVDOIp4T0wyLfQJcuq/fKfkoNHs572ijakJZtNeFSPJvBA==
X-Received: by 2002:a17:902:cf01:b0:234:ef42:5d6d with SMTP id d9443c01a7336-23601e78185mr142424575ad.23.1749401889406;
        Sun, 08 Jun 2025 09:58:09 -0700 (PDT)
Received: from x1 ([97.120.245.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034056f8sm40902275ad.161.2025.06.08.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 09:58:08 -0700 (PDT)
Date: Sun, 8 Jun 2025 09:58:07 -0700
From: Drew Fustini <drew@pdp7.com>
To: Benno Lossin <lossin@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
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
Subject: Re: [PATCH RFC 0/6] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aEXBH5r05FkTxpV+@x1>
References: <CGME20250524211519eucas1p218997c69b98b14d3af2eb6bf4e9d3187@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <aDJGgLZ9tITwGBxq@x1>
 <b5f4af17-05ef-453d-8f04-283590ae5b87@samsung.com>
 <DA5YY0YF28GO.3DONTQDLY6VBD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA5YY0YF28GO.3DONTQDLY6VBD@kernel.org>

On Mon, May 26, 2025 at 11:01:58AM +0200, Benno Lossin wrote:
> On Mon May 26, 2025 at 10:22 AM CEST, Michal Wilczynski wrote:
> > On 5/25/25 00:21, Drew Fustini wrote:
> >> Thanks for the patch series. It will be great to have PWM working
> >> upstream.
> >> 
> >> I've not built Linux with Rust before, so I'm going through the quick
> >> start [1]. I've also never built Linux with LLVM before but clang seems
> >> like the best compiler to use for Rust. Are you using LLVM?
> >
> > Hi Drew,
> > You're correct, Clang is the way to go for Rust in the kernel. I also
> > followed the official quick start guide. To answer your question
> > directly: yes, I'm using LLVM.
> 
> Just to let you know, there is an effort to get rustc to work with a gcc
> backend rustc_gcc_codegen [1]. And there also is the gccrs project [2]
> trying to create a gnu Rust compiler.
> 
> [1]: https://rust-for-linux.com/rustc_codegen_gcc
> [2]: https://rust-for-linux.com/gccrs
> 
> They have made a lot of progress over the last year, so we're hopeful
> that they become usable in the near future. But for the moment,
> Clang/LLVM is the way to go.
> 
> Hope this helps!
> 
> ---
> Cheers,
> Benno

Thanks for letting me know about gccrs.

I was able to build linux okay with clang:

make LLVM=1 ARCH=riscv -j16

It booted okay on the lpi4a:

Linux version 6.15.0-next-20250606 (pdp7@thelio) (Ubuntu clang version 18.1.3 (1ubuntu1), Ubuntu LLD 18.1.3) 

I installed rust with:

 rustup default beta
 rustup component add rust-src

 $ make LLVM=1 rustavailable
 ***
 *** Rust bindings generator 'bindgen' versions 0.66.0 and 0.66.1 may not
 *** work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2567),
 *** unless patched (like Debian's).
 ***   Your version:     0.66.1
 ***
 ***
 *** Please see Documentation/rust/quick-start.rst for details
 *** on how to set up the Rust support.
 ***
 Rust is available!

I'm not sure if that bindgen warning matters?

Thanks,
Drew

