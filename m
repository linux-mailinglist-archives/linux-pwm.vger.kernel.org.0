Return-Path: <linux-pwm+bounces-4582-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C3A0AA51
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Jan 2025 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5129E3A6D8B
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Jan 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6501B87EA;
	Sun, 12 Jan 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Io1Lji"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC52F56;
	Sun, 12 Jan 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736694170; cv=none; b=qyzfWu7YGthRPBkRxNboOPjDIdw0toXXR8Jw8saAiFAsHB9ZE5dbyI2ae/29szwkuLooKkGM3A1G2/2YfhKDH6Im1C+hXzpyg+X7qAtTNd7g5YNB9MXNxdbPJx3qL5C6vUJAJZT4wPkARUnLO/3MZFHHTH473Cn9KsMxFtjBcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736694170; c=relaxed/simple;
	bh=/gSr7cTaQiXE/8ycf+9rTOWpxC+7GUV6VnzDrdoe08M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rx2imVa5RoR/AVYw7Bw/BjiDLtolOLhQKT+dHwQ8E4zMs6vgR+frCb5hfED14dUKls9hniNjU9CM+dtK9kjJGSMUlbq/QX2OvF1EIXVD4rQIJSwGBzr2lEJAb+3PKmml/IRWs2pz5y6PB3N79no9zjSaplenSwXTHd0yDtXr+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Io1Lji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D562C4CEDF;
	Sun, 12 Jan 2025 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736694170;
	bh=/gSr7cTaQiXE/8ycf+9rTOWpxC+7GUV6VnzDrdoe08M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+Io1Lji4VTcIy5L2qZw3hsPp1I2VY+k2M5Fmjil5T+B3ZZILjNkM+QNNv+40ewcU
	 EVX8/iBz5ovy5/gqeoFL1KCXoYrfQ9gmuQWrDQorYqMAKDh/8s8DCOIfDGfiYY1233
	 LIGgEJmD/Z09MsqZEC/3H9OfAwBfzWB4zWuXqqtlQdcKYa/sPZ5xQhR57FDET9RoXe
	 Cml2S0ZG+fNo0s6ehMS/HcdGX0hSUFTjoPOuVOUAhkZpYcHSq2+8+l2aMzphBsEZPu
	 6bvTzs21r9thfh438LRbXAnvDvjx7x6ik63Xfpy08Cp13hOuVKLuoxfRUPC36Cd/sA
	 8jSTvfR5/Y5yw==
Date: Sun, 12 Jan 2025 15:02:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] ADF4371 refin mode and doubler support
Message-ID: <20250112150241.2333fc56@jic23-huawei>
In-Reply-To: <20250109133707.3845-1-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 15:37:04 +0200
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

Other than that little thing about defaults in the dt binding
this now looks good to me.

thanks,

Jonathan

> 
>  .../bindings/iio/frequency/adf4371.yaml       |  7 ++-
>  drivers/iio/frequency/adf4371.c               | 44 +++++++++++++++++--
>  2 files changed, 45 insertions(+), 6 deletions(-)
> 


