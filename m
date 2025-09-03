Return-Path: <linux-pwm+bounces-7251-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C2B42765
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD891BC31F8
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AD30F55D;
	Wed,  3 Sep 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkAjLtP+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE192BF3E2;
	Wed,  3 Sep 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918665; cv=none; b=jzjICWMV2Um11/+4CZ1xmG9iGHJd6aahpTAgAHZzvDJdp3g6YX4oHjuOL+GBD9uJ5FSj9v2raH+tZUsr2p09nyLeeTN3FPEuMUSevo+EDka+gf8Ia2Ywi3/xRpIJ87E+BRMTSaYImacaj8UJeCtuFzMznjXd0cb3OSrUIuQJyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918665; c=relaxed/simple;
	bh=h0JQBotyGKZ8xeFkzdNeUMq4ff3QX6MP44TiQVki3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltKFItgOrdVzSeiD5QRd6j/tXaIv+5mYoqiq5BCMCesOd+xMnv1n7NprFalHYBUEWcuzJvoTlFRbk3y1/h9LmaIpBicANlIvkmPiutif3MJh9RCUVuNtRmutEEomC3zmJ0zyNXsWsFrV7XIHsLpw3FarSFFMvqw8jt3PRj8UYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkAjLtP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73249C4CEE7;
	Wed,  3 Sep 2025 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918664;
	bh=h0JQBotyGKZ8xeFkzdNeUMq4ff3QX6MP44TiQVki3cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkAjLtP+n2Qq4WX1oBKfOg/iUZcH7QyLGqyb69ZAFsrLjpnuiuTrzWIXWD2cvU1SL
	 sEHW6TUQFOzPseYMe8hycudoNB2TgKjAsAaIsqVxdxrrhnmfblc4bKGYa07hZZwClW
	 nLMVZ0iRrMs7bjsQDDGSc/lyuGBonsrh+98LiSXThiR40hb2QCT6JM8Fp5o1IaNdDg
	 NKWYHJksg9rmaasuwKXaoXLW6KfyM/gwZpOcBCaGzM4QqR1nkKoTBIqTNkXWCpZqFt
	 H28Kwoevj9y9rkxEdZyXvQPpNbDnkVMXrZq17BFmADVqz54qGyFnXMXxb5UpQyrekF
	 ykGW4xRNmJ/Zw==
Date: Wed, 3 Sep 2025 11:57:43 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, lee@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250903165743.GA2493698-robh@kernel.org>
References: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
 <20250903000804.689a0a06@akair>
 <CANBuOYrcdzDytx0f=ZbpMujcNGn8RLGZwOJBE8FzPsGtt1y9iQ@mail.gmail.com>
 <20250903164643.0d0d2144@akair>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903164643.0d0d2144@akair>

On Wed, Sep 03, 2025 at 04:46:43PM +0200, Andreas Kemnade wrote:
> Am Wed, 3 Sep 2025 00:55:25 +0200
> schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:
> 
> > > > +                  - ti,twl4030-power-idle-osc-off  
> > >
> > > this allows quite weird combinations like
> > >  "ti,twl4030-power-idle", "ti,twl4030-power-idle".
> > > I would propose to rather clean this up to things used in
> > > twl4030-power.c and at the same time available in dts, also
> > > taking the brush in the dts. I do not expect that these specific
> > > compatibles are in use anywhere. I looked around earlier.
> > >
> > > Regards,
> > > Andreas  
> > 
> > Hi Andreas,
> > 
> > Thank you for the feedback. I've done a deeper investigation into
> > the 'power:compatible' strings to see if the schema could be made
> > stricter.
> > 
> > While cleaning up the list, I found an existing DTSI file
> > (logicpd-torpedo-som.dtsi) that uses the combination:
> > 'compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";'
> > 
> > Since this "idle, idle" combination is already in use, it seems we
> > cannot make the schema stricter without breaking this existing
> > board.
> > 
> well the only maybe fallback line  I see here is
> ti,twl4030-power-idle-osc-off -> ti,twl4030-power-idle ->
> ti,twl4030-power.
> But you allow "twl,twl4030-power-idle", "ti,twl4030-power-idle"
> That absolutely makes no sense.

Actually, the above would be prevented. String entries have to be unique 
normally except a few cases which use non-unique-string-array type. 

> Then the question is whether there is the need for fallback compatibles.
> They are needed if there is one piece of software which does only know
> the fallback and can use the hardware in some limited mode, e.g.
> u-boot using some mmc controller only without some high speed mode.
> Looking around, I do not find anything in u-boot or barebox for the
> twl4030-power compatibles.
> 
> And if we define "ti,twl4030-power-idle" as a fallback for
> "ti,twl4030-power-idle-osc-off", then it is a fallback for everyone
> using "ti,twl4030-power-idle-osc-off", so then the dts would need to be
> corrected.
> 
> There is one exception: "ti,twl4030-power-omap3-evm" is still used but
> not everybody knows it (e.g. pm34xx.c), so there is a reason for a
> fallback compatible:"ti,twl4030-power-idle"
> 
> And the rest, time for the brush and lets not totally mess up
> ti,twl.yaml.

This is all pretty ancient h/w, so I wouldn't worry about it too much. 

Rob

