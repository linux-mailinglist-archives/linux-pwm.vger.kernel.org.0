Return-Path: <linux-pwm+bounces-4444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F959F9A69
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDB71896A37
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B36223E76;
	Fri, 20 Dec 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djOfBf0+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089282210EE;
	Fri, 20 Dec 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722609; cv=none; b=IOb1lDTMK1tn8JKjSWQgAEWBH0auf+SVo5hljTqW79aaaLJjegl/H2fP7IYzCjBVNW9uW7Sl5Zw1QC4MHazzFxRoo/ZMbsvHbJq1f8LWD1KshPpJQLp9O6Ggq/XyGgsjjOvc7S2JwyZbjLa7nfbh+ttRr/z/PHj12WaqpmLstUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722609; c=relaxed/simple;
	bh=8MxBm/f/RHRQ3Gf57kt1o4LmZnVEmLGOSZcQVADCAN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGzg8qpPLJonsK/YOGRX0BuOylp7yVYYDYoYVamEuEEGHGTptuohVIBdSdTYV/oYUFJI9Fn2cRQYYyyrO80F85ge3CY45TDTDCygavjpI4PkV//G13dh3M1q2HTXcLN9YgZxzBxTulgPVT/fDJsz9gzYKYwTb9aTrA45QypxvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djOfBf0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C5C4CECD;
	Fri, 20 Dec 2024 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722608;
	bh=8MxBm/f/RHRQ3Gf57kt1o4LmZnVEmLGOSZcQVADCAN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djOfBf0+CwiRSXzRXh+w8lKqe3/DU+eQhTOIe0cGk6wkQTcpqHTvU1TSs9S7Bzx3E
	 +HnsJKzzQ25RD9xjhgHXyWJzyVedM7Ic9gxUmlWzffxj9UEUguIMq5LB6KbUWJKS0B
	 FWK21rN7nNx1/D11q1enDMD2180jDVum3lxYNAKkDWUv3QMXJCEzcoBB75/ud0TZDq
	 SGvxMPzdlLsNI0ehKXwtubqZPbxBR56FpXTty+XDavwLi1ATLO0+hQjifU5ckT+fft
	 sRFgiDAWHt1uP/vnsfjia8wzsc1qTDn+ETwEhNfsx07R+O/KvOy4bAqbokry5hKMMK
	 6E1wi8mMwZabg==
Date: Fri, 20 Dec 2024 19:23:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>, <wbg@kernel.org>,
 <ukleinek@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 3/9] iio: trigger: stm32-timer: add support for
 stm32mp25
Message-ID: <20241220192317.1266a34e@jic23-huawei>
In-Reply-To: <20241220095927.1122782-4-fabrice.gasnier@foss.st.com>
References: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
	<20241220095927.1122782-4-fabrice.gasnier@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 10:59:21 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> this new HW variant. Add TIM20 trigger definitions that can be used by
> the stm32 analog-to-digital converter. Use compatible data to identify
> it.
> As the counter framework is now superseding the deprecated IIO counter
> interface (IIO_COUNT), don't support it. Only register IIO trigger
> devices for ADC usage. So, make the valids_table a cfg option.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
I'm not seeing any compile time dependencies, so I've picked this one up.
Applied to the togreg branch of iio.git and pushed out initially as testing
to let 0-day see if I missed anything.

Thanks,

Jonathan

