Return-Path: <linux-pwm+bounces-7662-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE350C7BD4B
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895C23A2616
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C2530B53B;
	Fri, 21 Nov 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="i2XxyIq2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAE30B535
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763454; cv=none; b=XXOYjnulVXM2dzWAZ3StuH/vlcqUXfSWJKHG4zV77f7/M2yKZ2vEUmAT1YzhBLkiHoCBcQir0Fp+JNAyAg9TdqalP3sEXoyEhbKdL/WLENrs/06r+huqbdtWkn6fPk+PUgy4Ys2682zTLuyuOTXy891mQ+4dDRIybTEAxoiDYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763454; c=relaxed/simple;
	bh=nPfKjzTcE3w4oVrMFsWnuNd+KjEqpjKCbAHOfo4/sNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QunH4dS1IM9FQcDqN45s3jh3johh6c+peqj2aCboAEyLf3JEWJpSJ9WHxzOMdmDeqpkWJ4uK+C8n2tlHJEgOpaU3O6mBtSW9NhmvhxUNh/Xl+hD9NQtQhzMJl/K6VGDJYbNEZeph3g07u/CIOrVmrlhf7uKQVZx3bQbg1wDQTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=i2XxyIq2; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1763763128; bh=nPfKjzTcE3w4oVrMFsWnuNd+KjEqpjKCbAHOfo4/sNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2XxyIq2bADA1cFYkyQi8b3qVtgYBsZ89eYhp48pWWpQ87V2Y3WViooOL81731Ndv
	 Y4HJtY3W3VukUJrxQMgdoQ0mQH3PsDSMGfd3Q/woLDXcYQyTUzuCOaRrEFKwhk8p1r
	 d9Hz4GLFHu6M0TlY6todSpn4e4VM5brO8oLM30XRvPVFBMLpxYNl7oYyA8GBOjNH2p
	 Z96esU2PYVrvPbEKltVxw5yX6xtMqhP6sqAQvVn5IOzSfPCuUrdkKyoGS4OJhUSBfQ
	 dNzoFGP1dD/MvlCDDlquWTaFaFTDdlLRqD2YANUkZsril/tdWuNDSuamaulTjOQjF6
	 75S15vwVKsu9A==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id AE323100080; Fri, 21 Nov 2025 22:12:08 +0000 (GMT)
Date: Fri, 21 Nov 2025 22:12:08 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: PWM and rounding for pwm-ir-tx
Message-ID: <aSDjuAcJRhDFhmgc@gofer.mess.org>
References: <o7fry6bjh3trqrjb5vethqq4mumg37wjnvqafjlzuxc2ynedck@nb4x43jajm3j>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o7fry6bjh3trqrjb5vethqq4mumg37wjnvqafjlzuxc2ynedck@nb4x43jajm3j>

Hello Uwe,

On Fri, Nov 21, 2025 at 05:04:41PM +0100, Uwe Kleine-König wrote:
> Hello Sean,
> 
> I'm currently working on the pwm-bcm2835 driver, converting it to the
> waveform PWM API.
> 
> A result of that conversation is that calling pwm_apply_atomic() will
> result in the period being rounded down instead of rounded to the
> nearest possible value. Looking at commit 11fc4edc483b ("pwm: bcm2835:
> Improve precision of PWM") I guess you will be unhappy about that.
> 
> The obvious way forward is to let the pwm-ir-tx driver make use of the
> waveform API which allows better control over the actual hardware
> output.

That's very interesting, I must have missed the new waveform API. I agree,
this is a great way forward.

> I looked into the pwm-ir-tx driver to check if I can do the conversion,
> but didn't understand the protocol good enough to try that.
> 
> I wonder if you are still interested enough in the driver to do the
> conversion yourself? Alternatively can you point me to some documention
> resource explaining the protocol? Maybe there is even an easy way to
> test changes?

I'm more than happy to do the conversion, then I can also test that works
correctly with a logic analyizer.

> One thing that I noticed is that
> 
> 	pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
> 	pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);
> 
> is conceptually broken because the output of a disabled PWM is
> undefined. Many hardwares emit a constant inactive level, but others
> might emit active instead, or a random level or might even continue to
> toggle. If you want to be sure to drive the inactive level, keep the PWM
> enabled but use duty_cycle = 0.

That's very useful, I did not know that. I'll write a fix for that.

For the pwm-bcm2835 driver: do you have a draft commit that enables the
waveform API? That way I can start testing any changes I make to pwm-ir-tx
on RPi.

Thank you for keeping in the loop on this, I should pay closer attention
to the list.


Sean

