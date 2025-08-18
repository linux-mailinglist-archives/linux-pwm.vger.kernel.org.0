Return-Path: <linux-pwm+bounces-7086-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83EB29D68
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4439217A7DE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAC219E8D;
	Mon, 18 Aug 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MCg2b38v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8721322F
	for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508534; cv=none; b=DjtBOWHXSVO7cWvKsDGYg3KwuqgxJjlTxFLI5i12VGPhiTrLWJSuq2Q9MOFJAKiz6cI6Xd9iadfo3HJz8jzBH35kl27Z/DpL0BFLRSDqBGVaTx0d+itdlFYIQNZtp4t1SwAl1vI+GWjDFvVHPOfcZsY/FOKI38W8aRwAtxUMwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508534; c=relaxed/simple;
	bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj3ugy2TNxbqYjXrwCJybPtx4kF19hG+U98QuwFAMlH6vRu54fQtNPG8Vdv8WMiIZ+SAmaYegnnrzyl23XRA4gDWb+WzcE5pX/VSDAEDi+jWm/6RiHfLLO5nCdy7ill1S7//zk9Lw367epqexyXb77IkdanEg8iYVLpY2qaCheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MCg2b38v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so2453712f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755508531; x=1756113331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
        b=MCg2b38vdIzTsa29f954afgx2G/ZeJA+dmFWYqJut0f2DcqNleBQ2ygnSoGtDLG06r
         K+DnSNNIo/CayqtmHKWycnQ5OCtfqirM8K9KqvPSyyYgU6Yo5gLfvDkRpKOADN2K9ZM4
         TDDmV8txsstzwzBXCjME26YCMPBk/0ppfC8e8/5lSrSsyP4AFmCUHqPtWxjOIfUgYi8+
         UgUM0G1mdKqUGRd2Pfc8egeKdNrhy9yUXV83lyL32PoB50DVyAc1UJAyey7jizaTK0aC
         oOxAqELOhFEPHLJEoslDeDwHTSzCTi3XATFLVVV9+8UyjZ9E21t/Ba+PAvIlijBz7PVT
         U/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508531; x=1756113331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
        b=kYy88kliyNha45uHgAaNdbgMjy8m5Ssr5GdyIK9rF0li3Yp1RUM3kACOmhjfuYRrqH
         ufVUrAooTQK5bOjeUD9B0EU1DspEYFfZSiW9keI98EKuPCplbOLVAIhLJ0NjhdwatbFj
         iGLuKHugDprdk2VpigVXb/vLJoWv35sC3Ljh/68Qdvg13w3KyxEmnWzhby01RBmJFut9
         o2PON3h8czkDDl48OEpIqbEmgts4BacYKeigO/6att56oksY5TDm9ZpEkfsTZMKeSxCM
         +U7Nk+I8NFH1kE8gUKP8ZxsQNaEGV1P2g/99iydfo5swPcWYb/z7W505+pzKdsX8KFuG
         Dybw==
X-Forwarded-Encrypted: i=1; AJvYcCUDXdXJHRIgsDRcga3jwJxP0MxgoxBWCzXgPCOSV/XHTvOHnnHJJajBOuqBrGSt8Un6hWEvuSg3rRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPkWWvyQVoqXntfbfgiX1rjxKLOw+mnXnzO6wNaxtAGPKv5h6
	unXWmlmj3BisulU+GMqkXhA8N7z/6DRTfBK3StTf/Esu1XmEhG5z/A6F+EShq+aw7QU=
X-Gm-Gg: ASbGncu1CAU4v+3I/f6PKus+EJ+1uPZmQ0ps6N3/jhXPbWH5VLGlNenEikbFvgUxAXd
	is3BRYQWeq/vuPJ4DK0HfiZxdmnzJsFZkt8ECcCK4N+TPzlSBpU05LuUGSfK0IYBsUytEgko83z
	MXj4aquwhE/ivqc9uwrrIjVPOGaMN4tUcZh0H8g5g9a4CnlcO6dYO5RSiCpVP7JG2bidDgAy4Fp
	xUxdhl8HNyZpypWBedAeuejRaGTZ0O+3/x/awoYyr9FHuHnmoyiioj2dHBSMxdh+22QYh9N4S6f
	6WeDdEuqUYWnye90S3dZcPYgdvY2EdXuNAfukC6RSGyTs6mWCLajIGsO5xHbe122Ct2YFGvVgjF
	kgF0P/2uh7GGfjHVb3tIJKc8ufzO34JGtH4RFYGpzdVHq302/gLPGwIA3HVeu4bUT65gG5ugvFe
	KDb0mdLg==
X-Google-Smtp-Source: AGHT+IGb+Ck2Rc/beS4ZD2JAeOcF9Yx9/6P72Atsg9LKeyqqmAyuWKj+8gCMCQDmjg/gyjl81iEkpw==
X-Received: by 2002:a05:6000:3113:b0:3b9:53b:ee91 with SMTP id ffacd0b85a97d-3bb4c5b8043mr8984345f8f.17.1755508530770;
        Mon, 18 Aug 2025 02:15:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5aba02e2sm9753021f8f.3.2025.08.18.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:15:30 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:15:28 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <aKLvMLgZJ4fVLjph@aspen.lan>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>

On Tue, Jul 01, 2025 at 11:22:36AM +0200, Uwe Kleine-König wrote:
> pwm_apply_args() sole purpose is to initialize all parameters specified
> in the device tree for consumers that rely on pwm_config() and
> pwm_enable(). The mp3309c backlight driver uses pwm_apply_might_sleep()
> which gets passed the full configuration and so doesn't rely on the
> default being explicitly applied.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Sorry for the delay. I lost track of the review on this one so Lee didn't
hoover it up!


Daniel.

