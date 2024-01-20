Return-Path: <linux-pwm+bounces-862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D953D8334CB
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jan 2024 14:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83020284063
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jan 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9618AEAFA;
	Sat, 20 Jan 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="VUaePavB";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="mDrAf03Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840AEEDB
	for <linux-pwm@vger.kernel.org>; Sat, 20 Jan 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705757110; cv=none; b=VSnIsXf2+k4Q6qyKYNwZxFpLIKqei5Srk7CxZvMFVKVf0sbcdlSE0i2SgLdKQY5goTlT9J9eX2nBZ4oVXYO2ZiMjFdR0qRdLhtiy1S/T2bnb4umly+NxB/yJ8sw6myWDLP2X12wa4MdLtDhHxb3H1iMNTl4sthU7oF7+LtlndfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705757110; c=relaxed/simple;
	bh=RSP2se+u6DCISnP7SUu3FLuksvZziTDFqxykP1f62lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDS340n2TaPkW4TZSSnblKjEKRM2hUSXeVC5yC/T3cmWoqjzbhI5XalsFz78OE1GWh2VekhXTcH0zalBcQuQeC6d73Kqg7kDOprZTkBWNpBoam4Y1ZCCrNjxpoIiUwVfiI+ptyie6k+tO5gtbO5OxxIW2OBj+o+IsvrDg5wc6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=VUaePavB; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=mDrAf03Q; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nis0MFICALDl8ueriEsSxywhUejA62uue/J5cXFxeyE=;
	b=VUaePavB9fYtt07l5KK9wUaWbFvslcUItlQeESzh4+PC+JlHKIjokXvAqJq5A2UuZe6H1zG6M76ym
	 P1YY+x5r5Va+/5/mR3KXN+AxHNC1YLPpSoFb4S+8xtDvhQYB+BQ8kR+vZZ4NCr6OGGphDdehmISCj7
	 5Ynb/XUBqGxkCWzbTcFmtvnCSboHLKvnvE/0h8NHRJuIhsNrPYInYoTlZ/zYwr1r4gByarY6MK6kX1
	 w2vtccBTqwq94HXCNGzR6y2LD1oD6/Ub35yPmR2CnkL9xmiCDUWFGOPO8O7bVlzw/XcESFiHD4E9r6
	 q7QIKsn9LU0K5DTnpaBUJe/gnpm7wJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nis0MFICALDl8ueriEsSxywhUejA62uue/J5cXFxeyE=;
	b=mDrAf03QUCGkLVFzLWy1mb2nZd8MPZrNGY9zpcn2vCt5UPndHii5ObDnSFLMBBl9sOveAhAWjnD8N
	 UE5eIIHBA==
X-HalOne-ID: 298bbbbb-b797-11ee-a599-1ff1563c5748
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 298bbbbb-b797-11ee-a599-1ff1563c5748;
	Sat, 20 Jan 2024 13:23:58 +0000 (UTC)
Date: Sat, 20 Jan 2024 14:23:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Herring <robh@kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
Cc: linux4microchip@microchip.com, linux-pwm@vger.kernel.org,
	alexandre.belloni@bootlin.com, dri-devel@lists.freedesktop.org,
	nicolas.ferre@microchip.com, conor.dooley@microchip.com,
	thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	claudiu.beznea@tuxon.dev, airlied@gmail.com, lee@kernel.org,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
	conor+dt@kernel.org, tzimmermann@suse.de, mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org, bbrezillon@kernel.org,
	linux-kernel@vger.kernel.org, daniel@ffwll.ch
Subject: Re: [PATCH v3 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240120132356.GA345206@ravnborg.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118193040.GA223383@ravnborg.org>
 <20240119195151.GB938671-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119195151.GB938671-robh@kernel.org>

Hi Dharma & Rob.

> > To make the DT binding backward compatible you likely need to add a few
> > compatible that otherwise would have been left out - but that should do
> > the trick.
> > 
> > The current atmel hlcdc driver that is split in three is IMO an
> > over-engineering, and the driver could benefit merging it all in one.
> > And the binding should not prevent this.
> 
> I agree on all this, but a conversion is not really the time to redesign 
> things. Trust me, I've wanted to on lots of conversions. It should be 
> possible to simplify the driver side while keeping the DT as-is. Just 
> make the display driver bind to the MFD node instead. After that, then 
> one could look at flattening everything to 1 node.

Understood and thinking a bit about it fully agreed as well.
Dharma - please see my comments only as ideas for the future, and
ignore them in this fine rewrite you do.

	Sam

