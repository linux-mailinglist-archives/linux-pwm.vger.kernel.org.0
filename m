Return-Path: <linux-pwm+bounces-7068-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E070DB270C8
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF54E4ED2
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A710275B15;
	Thu, 14 Aug 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soiXpx2/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF226CE3B;
	Thu, 14 Aug 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206699; cv=none; b=JmQ5hjYvPYoZT3ocOQY1wkBaAqmQDaPEsSKqLCej3Wc+t76ASHq6KaYS9Hd8RNkP1Ih7ElhV4kQT4qvb/KEAZJKWvm1ltdA8zLa33nHjI0anP+z01A2cTVY9xY9eOR2py7jMGhXnWRG9bJa7J8bO3Q+tfoaX9C/yLX0X+FZTEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206699; c=relaxed/simple;
	bh=ZkPze2CRy6TGrshQh0qEp2iisTy50jGvZFAixZL50sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYlIGwJqm7Pxloc9p0T5kAAtt6i09QjS2wxninX8s+Tv228o2aKKkGEr+96kfl/mt7WfN9Wk+f80R1EjYkRRELs2XHZHuB3GfmnjkpYFOb7WpAF0c/10jrFPBuiBxYwRb46yaFN1h4NvzwIzwcVd+aGxkxr6z+zO3qOvxsUuWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soiXpx2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E6C4CEED;
	Thu, 14 Aug 2025 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206698;
	bh=ZkPze2CRy6TGrshQh0qEp2iisTy50jGvZFAixZL50sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soiXpx2/Ehg30HA8wao4TDS1XDczgMVlDjd8rleJHWRYAksTKPkuaVq1ms35VCRqo
	 hVwEX2Xy4HpEXNvIuqcKKhr3L1UwQ8PyvEABrOz2ViJsbSs7VFH1wTRTVUWMFeW8cT
	 I1VsrzDtlJfKo12ee70racW90A1hXokPBdccsWACwJvYfkdNVBXTkuLl3nufpVAo3c
	 33X0AuHjLVWkK7zNgqmSBwVO1gHmR1wsIT6+EnbF2cdbdzuJ1Jacfk9DlnbUEfsmGY
	 xdwa/zKdAzd8dKJdDcKCrAR4Cm64ziBYgaDwmvkgwIbBLQ282ZV8UFfuIi6kNCyAL2
	 +7hjQk8ubsEyQ==
Date: Thu, 14 Aug 2025 16:24:57 -0500
From: Rob Herring <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: tiwai@suse.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, ukleinek@kernel.org, krzk+dt@kernel.org,
	dmitry.torokhov@gmail.com, broonie@kernel.org,
	linux-pwm@vger.kernel.org, lee@kernel.org,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	peter.ujfalusi@gmail.com, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, shuah@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/8] mfd: dt-bindings: ti,twl6040: convert to DT schema
Message-ID: <20250814212457.GA3932653-robh@kernel.org>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-3-jihed.chaibi.dev@gmail.com>
 <175496188325.1486426.9118766970247515386.robh@kernel.org>
 <20250812145415.GA3607226-robh@kernel.org>
 <CANBuOYrCAcgp+x+TL98V3ih_ThyPF7x6VgXxVi4YnAdOC3nZvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBuOYrCAcgp+x+TL98V3ih_ThyPF7x6VgXxVi4YnAdOC3nZvA@mail.gmail.com>

On Tue, Aug 12, 2025 at 06:06:53PM +0200, Jihed Chaibi wrote:
> On Tue, Aug 12, 2025 at 4:54 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 11, 2025 at 08:24:43PM -0500, Rob Herring (Arm) wrote:
> > >
> > > On Tue, 12 Aug 2025 00:47:33 +0200, Jihed Chaibi wrote:
> > > > Convert the legacy TXT binding for the TWL6040 MFD
> > > > to the modern YAML DT schema format. This adds formal validation
> > > > and improves documentation.
> > > >
> > > > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++++
> > > >  .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
> > > >  2 files changed, 155 insertions(+), 67 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,twl6040.example.dtb:
> > > twl@4b (ti,twl6040): 'twl6040,audpwron-gpio' does not match any of
> > > the regexes: '^#.*',
> > > '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*',
> > > '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*',
> > > '^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*',
> > > '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*',
> > > '^(simple-audio-card|st-plgpio|st-spics|ts),.*',
> >
> > You will need to add 'twl6040' to this list of exceptions in
> > vendor-prefixes.yaml.
> >
> > Rob
> 
> Hi Rob, thanks for the feedback.
> 
> Wouldn't it be simpler if we put 'ti' (the actual vendor) instead of 'twl6040'?
> No other file is using the current name, so there would be no need for
> additional editing.

Indeed. Actually, just drop the property because the driver doesn't use 
it either. Just note the change in the commit msg.

Rob

