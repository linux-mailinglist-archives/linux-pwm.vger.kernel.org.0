Return-Path: <linux-pwm+bounces-7445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A1BD08B7
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Oct 2025 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4391897ADE
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Oct 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DEA2ECE84;
	Sun, 12 Oct 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrKYMwmC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896885260;
	Sun, 12 Oct 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290866; cv=none; b=quPw4cUM0SXsKwd5YEXCQro/MDG90d2sIuvQK8nbSBSY30lIAmKdUK7Ga3umkb4eMq3sLJ4RXOEjpmtKjKFXQqXdmjEq4a8mIorRPHI2993b3sOLHheqWAPacErjAt4hUu8uz2JHrm7nvE4QS+Mb1UZ6FUGhKKgKZNJDSP/PNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290866; c=relaxed/simple;
	bh=LMxUQeujUaXa15JA24eIE1Gd7RWwHhOJc9uGZ2F7jnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvYeCryEXVKUGKBWjVnwUlP6b8tOk/aaRkzULLHIGetTL3qRAq8E2e67kTEl2xmGOb8XMgfgzPe0B6o+sbJfKn5UuIIu0m14tYOORjmz1aFq8yB+00AgksnwG+fHKhq6kj+KAFDuandESISvXRReEDKgm5cOWElSKb+0oE4PIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrKYMwmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D930DC4CEE7;
	Sun, 12 Oct 2025 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760290863;
	bh=LMxUQeujUaXa15JA24eIE1Gd7RWwHhOJc9uGZ2F7jnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrKYMwmCm2KPnwV4jp4h3aCw0NcPMBuwBSX0gFXsSQmUi3tUt4eIVoBgzvX6PHr/Z
	 Hp+4a/a4QY6YEAZhedvVQDzDbvILE9hz/0oHXGNyboPyKd1aAPzsp9LrbEYlIr6Ia+
	 lPLFMFQ75VULKUZIPzDIJVSenY3xX0MWtMyrxfVU56ND0MbHdEYROvd1FBJi5HuI0r
	 +A6ka7/ipHargNWDKP7JlCVYcQ+/Rmknsrzhesli0lbjU3Tf9QHCPrevCncEffNll9
	 Rh6IKjOfC56QifpWJ0cUu7l4oC8F6/P/M00hbNh66E7FEk8OMnpki54pp3KABaj6b1
	 Z8tgnRkc565iw==
Date: Sun, 12 Oct 2025 18:40:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20251012184050.5e350077@jic23-huawei>
In-Reply-To: <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
	<7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 10:51:37 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Now only documenting GPIO setup to control ADAQ PGA pins.

A comment on a change log is my only contribution to review of this
version (I didn't have anything else to say!)

Fully agree on separating that issue out.

When we do implement it I 'hope' that whatever we/you come up
with there can be generic enough that at most we'd just using
it an extra example for this binding.  I.e. I'd expect it
to be mostly documented somewhere generic.

I liked the detailed explanation later in the thread btw.

Jonathan

