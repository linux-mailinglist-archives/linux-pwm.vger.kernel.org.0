Return-Path: <linux-pwm+bounces-7627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D671BC5C843
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904EE3A640E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BE30EF68;
	Fri, 14 Nov 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="koDfGSVz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D130E0C3;
	Fri, 14 Nov 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115249; cv=pass; b=lQYp7hSvUMYFl4+L6bXCR7rdsiW4h5p016Xy5JuOdXe7T+YnLxVhqIRHKBy39ENY12ZyqMOsk4+C83xlQiRY5/ppM1hPSr8/j/hl8l2qYhFdwKGs/28nd+ForvfIMVLng0bZ9CY9FXQxMMtRV93SSso5aPe8mKZ0ThasXr4kDqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115249; c=relaxed/simple;
	bh=RYNE6PVtlVSDSEeDFNjgfOuBo8x7I3/SUfpKaxDOh0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TepITHbo9+yMJV0m8bp2aLztSqiJzNoPRo9oOXYCMsF+EGmtw6O9w6XhXs1EzNxrLxjZBzIoeKPr+EfMUBpFOpXmO7dq+O6Bj+qmxYhIkdRrfr9aXGts4Dz/5tl9a2qbogHR7UA9LiLA0AxHJ1RndP/5mzsgRUpfvI8ildUeOWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=koDfGSVz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763115216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Uo1eI7o0dWFLKj7/RWiJpBOZ/6M8Z+p2twLTGb2REOEa4A0Tc+5V4SqJe8qS7BSZFhyF4CzP5bfubjvCMAccmCY2/9AkBRdPZ178hyhVKn5aGu1WKKkOi6VOgyiJnyib/X/FRYdVtmrGdVtvtUOYCJLCJc30bLO7ODHNIIaUauU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763115216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eFWpQbs9eju7XUpWo9+RZpsWisucaM4bHjkj9224ytc=; 
	b=AJeHo8Ql0yJqtDr3iYrwEObWN1LO4TyNPgUcJHKtUhZL2GHE5zbK8gnivvvN++0sbs1FgOvj8jf5m8fj4lGHwEt+C0Lcmh4oitdQP9co4peafzH7bI4P32zj47kEKRUO7hIfLL3fpURRKt1/9OrcnPuQ5Qcfg8bYJdr+sqFyHgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763115216;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=eFWpQbs9eju7XUpWo9+RZpsWisucaM4bHjkj9224ytc=;
	b=koDfGSVzRX8wUzMz6wSjHAiM9ouo73qkbfWQa79+AK9ddKM5YazjaayMrmw+Xcm+
	UWeZHT7+N8YhIHbx4WRpKK4uCigI/yRDj+QFp2e/KpNc06eGG6ujr90riCSFyfuZorT
	4x5D24VxcgTcLAEN4K8K8ib5Wm7FrDGXzvEAyuek=
Received: by mx.zohomail.com with SMTPS id 176311521554345.92633741698205;
	Fri, 14 Nov 2025 02:13:35 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Damon Ding <damon.ding@rock-chips.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
Date: Fri, 14 Nov 2025 11:13:29 +0100
Message-ID: <9941350.lOV4Wx5bFT@workhorse>
In-Reply-To: <fgu42esufq2x4fcccncqs3hlotih2gqmws5atotlaznuahoslw@34vblr6vboze>
References:
 <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <8a6e920b-9565-4161-9d71-63f924593c23@rock-chips.com>
 <fgu42esufq2x4fcccncqs3hlotih2gqmws5atotlaznuahoslw@34vblr6vboze>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 November 2025 10:51:27 Central European Standard Time you wrote:
> On Tue, Oct 28, 2025 at 04:16:26PM +0800, Damon Ding wrote:
> > Hi Nicolas,
> > 
> > On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
> > > [...]
> > > 
> > 
> > Tested-by: Damon Ding <damon.ding@rock-chips.com>
> > 
> > I have tested all the PWM channels in continuous mode on my RK3576-IOTEST
> > board.
> > 
> > Test commands are like:
> > 
> > cd /sys/class/pwm/pwmchip0/
> > echo 0 > export
> > cd pwm0
> > echo 10000 > period
> > echo 5000 > duty_cycle
> > echo normal > polarity
> > echo 1 > enable
> 
> Thanks for the test, very appreciated.
> 
> I wonder what made you test using sysfs instead of
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/.
> Is it unknown? Too complicated? Other problems?

Can't speak for Damon Ding but this is the first time I've heard of
libpwm, so I think you do need to market it better. :) Perhaps by
mentioning it in the PWM subsystem docs as a way to interface with
the kernel, if that's permitted by the docs people. (It should be,
since libiio is mentioned for IIO.)

Kind regards,
Nicolas Frattaroli

> 
> Best regards
> Uwe
> 



