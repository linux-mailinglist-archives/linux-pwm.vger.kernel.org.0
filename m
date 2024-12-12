Return-Path: <linux-pwm+bounces-4331-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81AA9EF1B7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2024 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8D417910C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2024 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD381241F45;
	Thu, 12 Dec 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A2lkm+7i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D845240378;
	Thu, 12 Dec 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020356; cv=none; b=njc+ERYOIOLE5+LMXrhilDfZAN1JDHbdKz/opJYvLN0ZMdgRB/SzBVR5LPn/YBjOIeaVKJeN/d3AjLAGkPrd7/4xMZbyrX8l4OqCTmQu9KyAkTgqbqO5vQwu+DZBHy0RzzZWJs/gzfIdDxdS/gYWzM25BpIwM2xl+iyD1kKtfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020356; c=relaxed/simple;
	bh=iHlvAPhIVvz36WX+GSreWLasztM4a4d7Y4bjIdntYxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSqNzC/oHKtnEGq4PHt5Uz+ef5FJUIeKLBsP2ro7czMcMwiwgkeeeWgqiNAOCwNwFoRMECUIa74Ud/sirCSvpXu3aqFWmK+TEHRzN2knYl7Sl8QVQ0dpHkXm4j1Q/GRiUxGUQUJa8npaIyJj6Ozj+z4AgFaF10IjoCitzbG7lTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A2lkm+7i; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87B2A1BF208;
	Thu, 12 Dec 2024 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734020346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weEPs92x2QpmerZO6QwiNlk+2/x1aW0o/MH6bYLLXS0=;
	b=A2lkm+7i/0O+VjBtCEN/O+xn/nj1go/JjrSekE+++rT3XURWq4gwZgIDgaQVehENc0D6Xh
	gQvgMn/y7noHWdGgZnVha1m2f98ojdiQsBPO1XLif1oi6E0Gzx2S/82cPX6/Lfr+vQgXoQ
	MLT/P+1gr6/RghCeU7fdV6rhTSIOysu0tWkFQA0BZ0uET5mAPBtHBoQt2CCsWm6wuk7RuE
	1TJu+gHW/upesLXnLsNjI+DXMxor7YY199t4MtWuNDkT7+yP15DvzSG4IwB5KUL6V9HFec
	VWbWySIg2213SykvPOngxIflDwLFSOLJauFcqQhmw08m0XWkwG82g9bZW8/mRw==
Date: Thu, 12 Dec 2024 17:19:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] pwm: Add support for pwm nexus dt bindings
Message-ID: <20241212171904.3350e04d@bootlin.com>
In-Reply-To: <20241202164459.157672-1-herve.codina@bootlin.com>
References: <20241202164459.157672-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Uwe,

On Mon,  2 Dec 2024 17:44:59 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Platforms can have a standardized connector/expansion slot that exposes
> signals like PWMs to expansion boards in an SoC agnostic way.
> 
> The support for nexus node [1] has been added to handle those cases in
> commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
> a nexus node") and the gpio subsystem adopted the support in commit
> c11e6f0f04db ("gpio: Support gpio nexus dt bindings")
> 
> Add support for nexus node dt binding in the pwm subsystem.
> 
> [1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pwm/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Any feedback on this patch?

Best regards,
Hervé

