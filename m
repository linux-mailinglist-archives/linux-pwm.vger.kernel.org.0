Return-Path: <linux-pwm+bounces-6894-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63FB12B87
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Jul 2025 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7357D7AA155
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Jul 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1528285CAA;
	Sat, 26 Jul 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAEP8Jjf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90ABCA5E;
	Sat, 26 Jul 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753549005; cv=none; b=SGheu4HD/jtgAKr4WQ9kfZu/tSqND+je6zgVXVMuqkf0XsvRKfycOx3wgDaDlV8Z7k3rPKr+HYGNyBt/0DwY7JanoEdzDur7DNjMrFKuiR7Opxn0jfy6n/AUZ/66kC/PBk4k20QiRA6OfyJRD3PQKHH5k2j+Rlrv6xPFjMLB130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753549005; c=relaxed/simple;
	bh=xCg92gP7rQbNoUCfPTgJWW0kbd3zy4lJS0U+Oc7rzE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qje7zDH+c0AdVGoFr40Q6FexClFBeNmVDAzBrjRKPsya3oB0nRb+jm8quKlD4t1g0u8xtx2KKPzHdbDjYi07jKV0aJ7pq7lnsZdwYj1+WTpg7As1BBB8ehBleABFZhX9n5/aK0mfe4iTRLdnAD73k+5wAhrBArNnCUDUcz0oyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAEP8Jjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CACC4CEED;
	Sat, 26 Jul 2025 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753549005;
	bh=xCg92gP7rQbNoUCfPTgJWW0kbd3zy4lJS0U+Oc7rzE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAEP8JjfEeyrcttfxZEbDEHjBgfO55KtsgsatqYzi1s6K0e+o0B9i+1HobATxhrgz
	 +ju5skj6e7otHw/yFssY+Bjt70NO4bd/+izWVOuzcdrSOqa+uulPsxFTzoM3Xeq49V
	 AGGzrn0xjrQ2UAQO8DSYY0CB+d6M/ybh2m8UPJPmDkIFBNYU+ynLBogKCzIrXibizM
	 0BLOcNlvaozyGjCVPWnYPQxlseiKodg4+AZgL0GVhv3GwfECx11ZyV5LIsTlKji3CR
	 gpUADD68JeDTNoH7ay0TTP1bPDXMBkhhg1l4F7f51c93YDevHyAcIBk8vb4tdScSmE
	 jT2MsyR9WgQGw==
Date: Sat, 26 Jul 2025 09:56:43 -0700
From: Drew Fustini <fustini@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alex Gaynor <alex.gaynor@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>,
	Fu Wei <wefu@redhat.com>, Gary Guo <gary@garyguo.net>,
	Guo Ren <guoren@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 8/9] riscv: dts: thead: Add PVT node
Message-ID: <aIUIy5ykeZi+BNXA@x1>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180907eucas1p10c0ca6b667debcc8139402d97e4ef800@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-8-0ca23747c23e@samsung.com>
 <175340623531.3513.5896709502242556676@lazor>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175340623531.3513.5896709502242556676@lazor>

On Thu, Jul 24, 2025 at 06:17:15PM -0700, Stephen Boyd wrote:
> Quoting Michal Wilczynski (2025-06-23 11:08:56)
> > Add PVT DT node for thermal sensor.
> > 
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index 26996422e1efe5d2dde68819c2cec1c3fa782a23..bef30780034e06b07aa29b27b0225ea891a4b531 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -669,6 +669,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
> >                         thead,pad-group = <1>;
> >                 };
> >  
> > +               pvt: pvt@fffff4e000 {
> 
> Node name should probably be 'thermal-sensor@fffff4e000' then.

Thanks for pointing this out. It does seem like 'pvt@' is unusual:

$ git grep -l 'thermal-sensor@' arch/*/boot/dts | wc -l
57
$ git grep -l 'pvt@' arch/*/boot/dts | wc -l
1

$ git grep -l 'thermal-sensor@' Documentation/devicetree/bindings/ | wc -l
14
$ git grep -l 'pvt@' Documentation/devicetree/bindings/ | wc -l
2

The 6.17 PR for dts has already happened, so I'll do a fix once I can
update my thead-dt-fixes branch to 6.17-rc1.

thanks,
drew

