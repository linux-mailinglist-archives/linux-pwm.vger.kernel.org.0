Return-Path: <linux-pwm+bounces-2209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112928CB462
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D8A1F22D1F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB6148FE2;
	Tue, 21 May 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="E2hvY6Pu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBF433AD;
	Tue, 21 May 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320684; cv=none; b=AYMKnKXnQP7cSozN/y7p76wB/9xJbg8SkOBDP9vZg7xrjrYULiCYxqpQgzlKPQ8KDCOFpnx4ehd8QHjyrpP0cVMTNzZBrzBv89WtyXPunvtbVFIltNORSC+MLXYj3WAhcUxMBXcn5mN/FJp2y3UwRtzF9F44r9rkj+mmdTypkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320684; c=relaxed/simple;
	bh=r3VPy55grG4HmD9HQEZNmYScSv+0YD8VyAqAQZNxQUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvgfQCoH4w9IBULV7TCfQdS5HVRIRBhdVBN2RJe42RzNiyrDOmuApkd/SA2PBhVp8qey9RXfjOkr6DH2d440U/THbBU4Ca1VW3qpQx3zCE5UUoyjFPTWCwUQ6ZSv2ONxRJUpBWmHXdK8M7jpOMR2iGTi8IyjHcJF4cAa+9le7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=E2hvY6Pu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EE62BC8E;
	Tue, 21 May 2024 21:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716320669;
	bh=r3VPy55grG4HmD9HQEZNmYScSv+0YD8VyAqAQZNxQUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2hvY6PuMZvrTKrsKT1LHuQjITBsscZlqyACpiuWTwIzOJMwwRevLvcR8VgBXPgHo
	 +oGdKfynZi9yRpe/xfr+yli4d1NWpdS1kWErCkUB9Rratks8TEhDr4bjeSLlmsMANK
	 bG2+aR3ecVZ8qCEHTrAHMI83UqZ9sYJVA3CrrsjU=
Date: Tue, 21 May 2024 22:44:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: trivial-devices: Drop adi,adp5585 and
 adi,adp5585-02
Message-ID: <20240521194431.GB8863@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-2-laurent.pinchart@ideasonboard.com>
 <920c3b0d-86ed-4616-989c-0d493a189c91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <920c3b0d-86ed-4616-989c-0d493a189c91@kernel.org>

On Tue, May 21, 2024 at 09:02:19PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2024 21:59, Laurent Pinchart wrote:
> > The Analog Devices ADP5585 is a multi-function device that requires
> > non-trivial DT bindings. To prepare for proper support of the device,
> > drop the related compatible strings from trivial-devices.yaml. They were
> > added by mistake, without any user in the mainline kernel, neither in
> > device tree sources nor in drivers.
> > 
> > Fixes: e5dddbedfe09 ("dt-bindings: add ADP5585/ADP5589 entries to trivial-devices")
> 
> I don't see a bug there. Just because there are no users, it is not yet
> a bug.

The bug (as I see it) is that compatible strings were added to the list
of trivial devices when then patch series that did so did not intend
those compatible strings to be used by anything.

> This should be squashed with next patch so you keep compatibles documented.

I'm fine with that.

-- 
Regards,

Laurent Pinchart

