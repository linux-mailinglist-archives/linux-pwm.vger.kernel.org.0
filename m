Return-Path: <linux-pwm+bounces-4928-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBDA37503
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814B73A7F78
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B631993A3;
	Sun, 16 Feb 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUV+pLz3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B484C8E;
	Sun, 16 Feb 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719483; cv=none; b=CKeGL/Ez1qE+2MsG3xQSFbU5C2xogqiD5AhDvJQijriXZqUZQcm4FsrOOLEWuxT7/Wa16DhuP0wLxdxZa7pwLQ+yhUNroalVyA+Vr5ymjpqTMZIHn6RxG7RzG1QTChJPOksdHyZqozE9xaMXKQ20kYHcOqF7+4k1QLRIlf61CBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719483; c=relaxed/simple;
	bh=WDLFEyorQjkxNYJpWa0mHuFGqptB4QMC3rloSWaTMas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDLAvgWydJyEhOOI1qPmYxDSVvLJ1ioAIl8CsjF7eVML7YC52c0B+ny3UAGRLN9oVcqFuk+MpUsmr5MJ6Ez9VztT1M6Q+7zSwAvDnxNjI4fAi8EZ4riFpYo89nevHNA82o6juXqxPTVLPw5wijbLRlUI4uQ/zLeeChMeoDk4yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUV+pLz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53126C4CEDD;
	Sun, 16 Feb 2025 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739719482;
	bh=WDLFEyorQjkxNYJpWa0mHuFGqptB4QMC3rloSWaTMas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kUV+pLz3AQgJu/ApDhx3QQZqT15wWHCS8waQU3kC7rn3o6bjY8CUJSaw2imPV79IP
	 fqi55ay1xapImVocDyWXf17o3o25j9Fi8KbMHEO+ZR+CNpl9EOPiM4p8b96p8oiMgJ
	 ZDrFV5xJYcarKX/p0BEJVvitauYCwcd99KMfeii7aeBROGIACjJBcwK1dRUVm/LrPt
	 iAA9C4nFg3Iv5HAAWuW6AhkZoAjq+rqNxJdMcdSJy8EksleEa4SzqIs9YJllILCcCi
	 Z4qDyQYiGjM6plBnd9jVNKykqhd0C/3g7DY7jWHPOk5BpF9N+JJdZOWqWsE2FclGxE
	 oCsaFIcw4ZLgw==
Date: Sun, 16 Feb 2025 15:24:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v13 0/9] Add support for AD485x DAS Family
Message-ID: <20250216152411.42a3364e@jic23-huawei>
In-Reply-To: <20250214131955.31973-1-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 15:19:46 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD485X fully buffered, 8-channel simultaneous sampling,
> 16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
> common-mode range inputs.
> 
> Most of the review comments which make sense in v9 were addressed. Some of them
> might have been ommitted, especially those that are a matter of preference.
> Since we reached v10, I tried to cover everything that was pointed out until now.

Series applied a little speculatively given we don't have a DT tag for the
more trivial dt patch.
Needed some hand tweaking to apply as this raced with the ad7606 changes
in adi-axi-adc.  Please check I didn't mess those up.

Pushed out as testing for now.

Jonathan



> 
> Antoniu Miclaus (9):
>   iio: backend: add API for interface get
>   iio: backend: add support for data size set
>   iio: backend: add API for oversampling
>   iio: adc: adi-axi-adc: add interface type
>   dt-bindings: iio: adc: add ad485x axi variant
>   iio: adc: adi-axi-adc: set data format
>   iio: adc: adi-axi-adc: add oversampling
>   dt-bindings: iio: adc: add ad4851
>   iio: adc: ad4851: add ad485x driver
> 
>  .../bindings/iio/adc/adi,ad4851.yaml          |  153 ++
>  .../bindings/iio/adc/adi,axi-adc.yaml         |    2 +
>  drivers/iio/adc/Kconfig                       |   14 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad4851.c                      | 1315 +++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c                 |  148 +-
>  drivers/iio/industrialio-backend.c            |   60 +
>  include/linux/iio/backend.h                   |   19 +
>  8 files changed, 1703 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
>  create mode 100644 drivers/iio/adc/ad4851.c
> 


