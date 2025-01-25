Return-Path: <linux-pwm+bounces-4729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEDA1C336
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jan 2025 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38B33A79E4
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jan 2025 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D12080CC;
	Sat, 25 Jan 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u26d/8Nk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7826AF6;
	Sat, 25 Jan 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737808800; cv=none; b=heP74XMBD1vr9fAvURxBDN1C5yevZ1JwrDuPI7+KHWzEreWtU/py3kl1pKbU2VNB75OwsTGWBQlsj5zVkSTJF3HNuOtlonW2CrzFAs+fSxX3c7gubbvipNtgzMQF5x1sjEAFC5DcJCNJGUjJDNhsxuhZwDZakYhBKMNbjc5HJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737808800; c=relaxed/simple;
	bh=CYwN5PTei4NXJ1sDlasLbcvLy1SaWnhNgZ+PknACwRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH58+kyWtIJvVPbsvC5L1z+PSuCp0xiRSUFxAwUDFJeUwvaDv4Z+/S04ZCP/34FiRjKYMHhKIDmimWjXFATTEoPunTVhVFKXZ1m2snO80KGoPzbABI7hvswik+tiBhMTnthrwWPwb7y7m2lFQ924E+MyIPIVuAOnEaY62rsxMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u26d/8Nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A253AC4CED6;
	Sat, 25 Jan 2025 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737808799;
	bh=CYwN5PTei4NXJ1sDlasLbcvLy1SaWnhNgZ+PknACwRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u26d/8NkacPTVpC7Ihn75AXxMD9/Zmyx3EG6bT/rXTdNN1uPjqPxY1xuZNaqSRePs
	 LZz22zNLJbtSTXvgTHoCjoRqUNsIPReczUxA8uRgYoQRt6J5l+/1WkMA63ml4zppJk
	 84loSXIdBvOM6BrUNcbF8INZImullPVyAOIXrODm2+j019gajCeq+0dR8klohDu+cE
	 wOuH4CDxsg80csPE6Ihl7ANJN6GhVI3FN3NdSeugmKBXyKJNHq5ya2xOVQkUwK/GH5
	 FLbH/wMmxuU+6MdR1Ce7Xw8Imse7+RLfF/4hL56VBA9dQj+R3hgqFKik7lZEkkA5GE
	 kpBOxGDgYIPXQ==
Date: Sat, 25 Jan 2025 12:39:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] ADF4371 refin mode and doubler support
Message-ID: <20250125123951.2e095181@jic23-huawei>
In-Reply-To: <20250120113408.24395-1-antoniu.miclaus@analog.com>
References: <20250120113408.24395-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 13:34:01 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting between single-ended and differential
> reference input. By default the single-ended input is enabled.
> 
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
> 
> Add support for the reference doubler. This feature is enabled
> automatically to improve noise performance if the input frequency
> is within the accepted range.
> 
> Antoniu Miclaus (3):
>   dt-bindings: iio: adf4371: add refin mode
>   iio: frequency: adf4371: add refin mode
>   iio: frequency: adf4371: add ref doubler
Hi Antoniu

This needs a rebase as there was some recent cleanup from Nuno of
the driver so your set doesn't apply.

Thanks,

Jonathan

> 
>  .../bindings/iio/frequency/adf4371.yaml       |  5 ++-
>  drivers/iio/frequency/adf4371.c               | 44 +++++++++++++++++--
>  2 files changed, 43 insertions(+), 6 deletions(-)
> 


