Return-Path: <linux-pwm+bounces-7250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10DB423F8
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407AC3BA9A3
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486B23D7DF;
	Wed,  3 Sep 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3d9aSZPs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6A1EA7E4;
	Wed,  3 Sep 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910810; cv=none; b=rRFQ1jg503QpJTivRqVLzPbfuAuvJO067hhXLZUnWx+rgTksAqpLmAuE+i5G7M9lN+sNgZbylKgmsZeCyfcHQTqPMf04mx3ixaF/uFuQKr4ZM09dyE9GfzhSrtn6pflXAH6X/qDFzq4bMOYfW+Qz2TUDSvrp4hro1YFISs03tDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910810; c=relaxed/simple;
	bh=J1PKNIgZOCKgEUdO8M5JDkq4fiPls0L34C3HgSWF9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex2MxdLN3/dbjpmX/lo+cxTCA+r1ujPSqNZhOp8uvme7hwvAo8YV76GTH5eKdp+WH4UdjvmRZXSHBiaP/2FdAsLlED75twshAe0PI+REIbfyP/TMDYXAMpUYjOmBujOdQ3NUWlRfqfO0ESN4tHZMGv+EzW09UnqaygyDL6pJv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3d9aSZPs; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fj3F4CR220kgIik6Toc/cmZCKNEv2XOOqIQqcF1ImAs=; b=3d9aSZPs3YmAbFASAiHJJcRzGD
	fl2yMQ8DmjfTp6BbqLH7rIT2d77qfEB5Z+Y3/TvVDjT6wUAtXu/ENwN6EG2X//C4oeWM/kjAdgfxL
	A694dMtmMqBNIb8h0atjUe70ar36QSdcZGS2V7lVdWAhrq/ScnBLUi3G/rdz/Vs4Ojj/3MbHG320S
	ZRrjHpfBqZtlgfWGJBUaKIHpb6URoYypOkt4AYTv/24i82Ubg9uaXxpMpVw/4TTofxGQ15mggaxe0
	BuFsZMXnY/HvCX/NBQPB2UnAzG31UmQZCKP7YdTXyJCqScWP+DXLeNLysRPnEhCaCLpypNh/VCOzx
	J06xky9g==;
Date: Wed, 3 Sep 2025 16:46:43 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250903164643.0d0d2144@akair>
In-Reply-To: <CANBuOYrcdzDytx0f=ZbpMujcNGn8RLGZwOJBE8FzPsGtt1y9iQ@mail.gmail.com>
References: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
	<20250903000804.689a0a06@akair>
	<CANBuOYrcdzDytx0f=ZbpMujcNGn8RLGZwOJBE8FzPsGtt1y9iQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 3 Sep 2025 00:55:25 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

> > > +                  - ti,twl4030-power-idle-osc-off  
> >
> > this allows quite weird combinations like
> >  "ti,twl4030-power-idle", "ti,twl4030-power-idle".
> > I would propose to rather clean this up to things used in
> > twl4030-power.c and at the same time available in dts, also
> > taking the brush in the dts. I do not expect that these specific
> > compatibles are in use anywhere. I looked around earlier.
> >
> > Regards,
> > Andreas  
> 
> Hi Andreas,
> 
> Thank you for the feedback. I've done a deeper investigation into
> the 'power:compatible' strings to see if the schema could be made
> stricter.
> 
> While cleaning up the list, I found an existing DTSI file
> (logicpd-torpedo-som.dtsi) that uses the combination:
> 'compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";'
> 
> Since this "idle, idle" combination is already in use, it seems we
> cannot make the schema stricter without breaking this existing
> board.
> 
well the only maybe fallback line  I see here is
ti,twl4030-power-idle-osc-off -> ti,twl4030-power-idle ->
ti,twl4030-power.
But you allow "twl,twl4030-power-idle", "ti,twl4030-power-idle"
That absolutely makes no sense.

Then the question is whether there is the need for fallback compatibles.
They are needed if there is one piece of software which does only know
the fallback and can use the hardware in some limited mode, e.g.
u-boot using some mmc controller only without some high speed mode.
Looking around, I do not find anything in u-boot or barebox for the
twl4030-power compatibles.

And if we define "ti,twl4030-power-idle" as a fallback for
"ti,twl4030-power-idle-osc-off", then it is a fallback for everyone
using "ti,twl4030-power-idle-osc-off", so then the dts would need to be
corrected.

There is one exception: "ti,twl4030-power-omap3-evm" is still used but
not everybody knows it (e.g. pm34xx.c), so there is a reason for a
fallback compatible:"ti,twl4030-power-idle"

And the rest, time for the brush and lets not totally mess up
ti,twl.yaml.

Regards,
Andreas

