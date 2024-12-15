Return-Path: <linux-pwm+bounces-4356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830E9F23BF
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2024 13:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C93C16401B
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EAF17DE36;
	Sun, 15 Dec 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvGWwtJ4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842231A89;
	Sun, 15 Dec 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266120; cv=none; b=Dsz78NsTvED5lQctXspV8sTf7LEpKm/YGzlcUDuFwdxbBR3suLeX02C+nzgJKTFSgDCNAsBYQiSx9udDd3ZN3fQI5DPoLdiLevt0HsaZtn2F/d0Vmz4q4Bi1xTDFeAe6a/kfjqUgaYnY1799cixONUwfCRbkeDgMISvcWAd9F3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266120; c=relaxed/simple;
	bh=ZL1fWrUk+ebtdOJXrTQ1Mq3uWwySJzxwsNo84//nb5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufLRuwp/wpQD9Ri6Djsa03Pr4ja1OPdc5DLQCYJQjZfXDxCaLg9pooYxg9VHEa90QJ6two8hnj64UsUVmGNOtJ8Ezb7C3o4n76I99Ji1xp4jsIv1HpgMn6bAePOJrw4Hbamxjr2+jzFXjC4BIOkJsfW36iv4Dx8iNKrrfP08AcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvGWwtJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135CC4CECE;
	Sun, 15 Dec 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734266119;
	bh=ZL1fWrUk+ebtdOJXrTQ1Mq3uWwySJzxwsNo84//nb5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PvGWwtJ4kTQH+rehSn7qRElhhAGDB/6y/xE8iqV+O3MCOR60IkQQ69ROjARd6ve1r
	 rCvFmbOs7k8j7D/Krl96PTLIHyZ2tAWIVeBj60IemJqXqeGRCH3c/LisS1QPYssXLu
	 rMQQDkzQur/1+1hqMCNtnsZ7zWbPrVhMdG+ee3yLdVErDU9WZRHGB0ann6uULdHdAQ
	 6DeCpEG13RhOuXMKZDnSh5laWEz8IKaqLCUOrDGBaM1O05dPFHwdp6g1OgCBez4qa2
	 zoBetC0Mx1e7aKtjKO00ms6bzG/ZPIEYAFgAhZTpw76wyM/dIP0ox31vkgFdjaaqDL
	 5a9Qdib11amaw==
Date: Sun, 15 Dec 2024 12:35:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adf4371: add differential ref
Message-ID: <20241215123512.1d2bbb3d@jic23-huawei>
In-Reply-To: <20241209104201.25205-1-antoniu.miclaus@analog.com>
References: <20241209104201.25205-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 12:41:31 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for enabling differential input reference.
> 
> By default the single-ended input is enabled.
> 
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - improve commit body.

It still has the same question I raised on v1.  Why is this not
selecting between what I think is two different clocks given they
are wired to either one pin or two.

refin, refin-diff

Please add a cover letter to all series of more than 1 patch as it
gives a place for general explanations and discussion.

Thanks,

Jonathan



>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..dd9a592d0026 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,11 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves lock as
>        measured by the digital lock detect circuitry.
>  
> +  adi,ref-differential-enable:
> +    type: boolean
> +    description:
> +      If this property is present, differential input reference is enabled.
> +
>  required:
>    - compatible
>    - reg


