Return-Path: <linux-pwm+bounces-4857-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3BA310FA
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF824188D424
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA08254AEA;
	Tue, 11 Feb 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h61IAedW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04951253B7D;
	Tue, 11 Feb 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290332; cv=none; b=qOC+7eNpvl6pA4rV+uUaGYO5TkJvvdCTd9/eW4p/+/YAmCAU+PgvoETddI49HP4O9MZqOmanvY9zfL4a4aB1gzhoxmBuu/76/KvRGV79rZFGk4kE8YJuS4a62PVBebz9YfYqStK60YqM18AZzf6xyl530twEb2uFdm3bgx2cvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290332; c=relaxed/simple;
	bh=XAmJT4YLfE1GmV8k7jA8oiQS+4DF9naVy5ayUlr3gfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVAMC4ih0RPQ1zcU53aTJz5w3QRiH0hyS3EBHTrT5RdJqRHr8pW0Cc8941YtF6H4ykh/7UpvfNNAzzygFoHupIpuNwYQtDvIL411x1+0N1bjM89acnk7MqJOCYPkxdNSzUDjvqyJOhO5wjoTIpW8EIO6fvcMPJeIua8TEUo6NkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h61IAedW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A0C4CEDD;
	Tue, 11 Feb 2025 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739290331;
	bh=XAmJT4YLfE1GmV8k7jA8oiQS+4DF9naVy5ayUlr3gfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h61IAedW0WZ/MSnh4rTUDSXKIomWuw+PhQyFn1Bo0Iay1e6eMzUc4VjG/3DvBRGBj
	 Fnzb5J/AWtwRtlXkswp1kCPR4BtcdB4chZUT9ocyJsLswckVSPr5lRK5KQ5wcafPUj
	 hl7++gfGrt7P+j+/LQ/8xb0Y2OsI3JWNWeOPH2mTtYiGfdXDS79wWqpLF5lE4gwx4d
	 6t0Y7HunqUgzh+y2o2p9IktjURicCZd/P/zU6Uiu/4fcer/JRx69rkUeG7/XPE8Mqm
	 NLqE29AUFG5QA93bO4Rd6PU7s08akOLpf9hKoqx/FFhqIzlYpram+bv1gbrZx8Ttnl
	 sYEXHipJ/xoRQ==
Date: Tue, 11 Feb 2025 10:12:10 -0600
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pwm: pxa: Use #pwm-cells = <3>
Message-ID: <20250211161210.GA354180-robh@kernel.org>
References: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
 <lzlzq4fh3762kyezzr7eqnbkgsu6nbvzgi7yqzwy5tbsrb4tg2@gdpjz3cqrqq6>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lzlzq4fh3762kyezzr7eqnbkgsu6nbvzgi7yqzwy5tbsrb4tg2@gdpjz3cqrqq6>

On Mon, Feb 10, 2025 at 07:31:08PM +0100, Uwe Kleine-König wrote:
> On Thu, Feb 06, 2025 at 01:06:24PM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > this series' goal is to soften the special device-tree binding of
> > marvel,pxa-pwm devices. This is the only binding that doesn't pass the
> > line index as first parameter.
> > 
> > Here the #pwm-cells value is bumped from 1 to 3, keeping compatibility
> > with the old binding.
> > 
> > The motivation for this was that Hervé sent a patch introducing pwm
> > nexus nodes which don't work nicely with the marvel,pxa-pwm
> > particularities.
> > 
> > Changes since (implicit) v1, available at
> > https://lore.kernel.org/linux-pwm/cover.1738777221.git.u.kleine-koenig@baylibre.com:
> > 
> >  - Use #pwm-cells = <3> also in the binding example (*sigh*), pointed
> >    out by Rob
> >  - Add review, ack and test tags by Hervé Codina, Conor Dooley, Duje
> >    Mihanović and Daniel Mack. Thanks!
> > 
> > I intend to take the first patch via my pwm tree. Assuming the pxa and
> > device tree maintainers and bots are happy now: Dear pxa maintainers,
> > please tell if I should take the whole series via pwm, or if you want to
> > take patches #2 and #3. If the latter: Do you want to delay application
> > or should I provide an immutable branch for patch #1?
> 
> I applied patch #1 to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> now.
> 
> I don't know yet what should happen to the two other patches, but maybe
> it's a good idea to wait a bit anyhow to have 3 cells working for the
> pxa driver for a kernel release or two before we switch it.

The dts change will never work with a kernel without patch 1. You can 
somewhat mitigate that by backporting patch 1 to stable. If users aren't 
doing stable updates, they might not be doing dtb updates either...

Rob


