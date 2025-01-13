Return-Path: <linux-pwm+bounces-4583-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E720A0B141
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 09:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499A61884798
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 08:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957023315A;
	Mon, 13 Jan 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW0Zyn4O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852548249F;
	Mon, 13 Jan 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757428; cv=none; b=Z8QUDalEVRgjoG5HAFLfFsTSyUe3iu/i+ByXiv+05PUeNsWDsNHWnWzs2iahyguOPPDuJMSDqjfidFbL3ZyN1/M8DQAf3Hftdl1fLMLrj6gV0QB6hMfyJJKTrtJ+6grGl2p/J++3LWpX1h1bQz6ahB3RNhdyf9MkAqwlBmFIHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757428; c=relaxed/simple;
	bh=dpvkAEpxF6mBVe4BNBqZTcRAkzFIeejvQ5WZMpPBRq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx1YgajGkgWXiP3jtTHCLNwskaLy30v9UyyChvKxf6g3GKn3Xn4wvSngdqvlaZrKEBBnxrgWN9UuWFLqVRSCNh7ZZY1HKdViXe8KdDOoa94q89sM0RKXM2s5Qf4B6OBD3+mFVq6i3Jw7EaHimCfvCGf908r/IRg+Odoff9vnb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW0Zyn4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEC3C4CED6;
	Mon, 13 Jan 2025 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736757428;
	bh=dpvkAEpxF6mBVe4BNBqZTcRAkzFIeejvQ5WZMpPBRq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW0Zyn4OM8Mk/Zyxb9Iz7S50JmTUo1Efn7KKJGKfWDDtlDo/kff1zrNrwl6e84gLY
	 Mt2EPgLRCsvNAXuTjEvYO5E8i9IIFLTlifeamxuQoUr6ikeFUeEGa9ZwcWjwSbS/iN
	 umouNj+ralkmi6ECScM2Zct2noc+pcyVjLLDqDA73SfHMFoPjxy/PmuQRswULqa9JI
	 bT+p+qH3RjkI8PTJRvicIMAVf+uh2zxnS8fLoco3Vurf1/dA7DI3cxFEEAiat30k4l
	 Z2G3GYSnbVVWSRuZo8TYFCFrlTLYsXErcJjptMnxWYdqd9jmBYnMpPeZnU7NcIhyjq
	 UTxdm3+g9eV5Q==
Date: Mon, 13 Jan 2025 09:37:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
 <20250109133707.3845-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109133707.3845-2-antoniu.miclaus@analog.com>

On Thu, Jan 09, 2025 at 03:37:05PM +0200, Antoniu Miclaus wrote:
>    clock-names:
>      description:
> -      Must be "clkin"
> -    maxItems: 1
> +      Must be "clkin" if the input reference is single ended or "clkin-diff"
> +      if the input reference is differential. By default single ended input is
> +      applied.
> +    enum: [clkin, clkin-diff]
> +    default: clkin

Which pins are these? I went through adf4371 datasheet and no reference
on clock inputs like clkin or clkin-diff.

Best regards,
Krzysztof


