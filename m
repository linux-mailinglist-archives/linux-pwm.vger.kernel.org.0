Return-Path: <linux-pwm+bounces-2947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D09446CC
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4238283D4D
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03016F0C6;
	Thu,  1 Aug 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TjevA9IV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99B61FEB
	for <linux-pwm@vger.kernel.org>; Thu,  1 Aug 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501713; cv=none; b=tV4KGhoAFMGNzFswhb0LIS7uSd8NUeSB2oQdCPz0DAbTxmWWWidwT0JHasDmSxl9rrlFVxYmpRXMT5r1Qt0LuHQB8PnQB5m52Ej8ZysY5/wkXY4MjtIV6MQxUwdm83GG11JZQXtrOzpPlOsuOfv6fMJy+pFSbvgDqEiwP3yK0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501713; c=relaxed/simple;
	bh=aw9s8bH889T89YP6YbwpNL913F1GzGilpacEd/D8P4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bks17iMc2ToZPx06o/fHi9SCLL+sbqLhPaFFFtbDKoeeHfrobv4EhZ3xMuSLNm2GWSk4zDjeE3JIXjX9QmQdSm/xQFY7FeOvdwQFeWflkCgzjMpCfTBSR+M740W1ZVFhpg5BClB/1wrx6iFVh041Y6uhLKuMDWn/HoNE78NpEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TjevA9IV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42803bbf842so58245445e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 01 Aug 2024 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722501707; x=1723106507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIN4KBQZ4pBCfdikPcgAEWweUfMO0lXsLC8I9nmJx2I=;
        b=TjevA9IVEtF17sra0Oec8TIWEnhLSi3foJBa55lgfTfQcJhgctMEz6Okrk9NTqAHNk
         Oge7Q2A23rqSc+YSEQtjdtZH+VZYypygHj8hHFa1XtTKUBxttYNbe1iOg9eSdSnRfDNh
         RLVzSh28b9ew0IsC/E+1x5WkdPKo18J6/jMn65lQYompDMqIR7NQgLcRDKKl9ig3iSPZ
         jdGIOnf8NA2MjL9W/83UEunzpY2kavPFd6FUNJee74wZpdKt8kKuGUq7xr7LLuBI9f4T
         lzc+J1fR1vpKl9t4xnFrCld/M30QEtgZBYLz3qTDpshoyAUC6OIrM0C64yUYuh5q9xrB
         nMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501707; x=1723106507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIN4KBQZ4pBCfdikPcgAEWweUfMO0lXsLC8I9nmJx2I=;
        b=HmEUVs2790XZwW8wO2C2idtq9UTURbXezpj3luyndWx8HglJ+zZ7YbxC58DJky6LjK
         QW9ZnAaqKqyU9iKh8SYO74POfF6E38hrwSOWmUzI5tvjlDHXaJzSL9pbBT6Irc8PMfcB
         AqoDsSl3eq6/v1kpvN20/B0WmMwDTR4BHX97dORJdWQDUeYJ8DmIN0QDV+ph6ycWcCvc
         1xqaKoRtaFn17D/xagERFRIaghuDhBLm/CmtSuB4EkmxtbwyRvoeEYWbMG6N4Bk1yuVr
         BsL7iUHRJc2b69qKNYsTT7lRdISJ/mX8i1OgvfoK7nmReOUOWDDfUmMQINOkd2k5OOQe
         hA3g==
X-Gm-Message-State: AOJu0YxbJiFv6zb1K1BuEqz8C62GERpozp3ldMbL9gmITv8cSkHMJ9PK
	JzC9lPCLQK9XzMRxlGPxisA7WIhs4h9DbrRsSEEhM/jD4DCK2pMnSCybspHmCl4X5K0CWzHuXUR
	z
X-Google-Smtp-Source: AGHT+IEnt1KPUDXb7f5QTSvgXAcJ5YPBVa0z/LPxP9R55nTDeIaLCTwSH5+5oMPbf8egz1Cxbi9z5Q==
X-Received: by 2002:a05:600c:4f45:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-428a99dfe89mr18783405e9.6.1722501707318;
        Thu, 01 Aug 2024 01:41:47 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d98aasm18927393f8f.30.2024.08.01.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:41:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:41:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Use of_property_read_bool()
Message-ID: <syfawfdkulanw7kile7qfg5qpfzakaqolh2qkjqwyarskgg2sg@ond7ytjil2yi>
References: <20240731191312.1710417-25-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crydygo6vpaqs2bx"
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-25-robh@kernel.org>


--crydygo6vpaqs2bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 31, 2024 at 01:13:03PM -0600, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me. Unless you object I'd apply with adding
"omap-dmtimer: " to the short log.

Best regards
Uwe

--crydygo6vpaqs2bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmarSj0ACgkQj4D7WH0S
/k5Qvgf/RPDM4kB7/fcEZF0W6KAFeH80jbWn2u9+QoSp7SmnBsBVc1MDc1kVePJU
2DnOsOAkra3cQbd9v83IBB6JujrBWALvLxHn3ax8zgtLYkjkwcfYKO/a25+l1S8a
XkU8tyzlXGy7rfnTtWPoT/so25+xQTzD5iX1HP2KptwE+pf0p/dvnOGqx1B+cvBC
iYvS6VpuJNqSdU8aK/ffaTepAKjUvm6d+eRiFeFcnSjsZ8vzntHwAl+wnH1sZ25h
ohpZg7UbdrHcNIL6BtcXzyHiuEFY7POvR4LLAlfaZPsVBBI6Yx/sMDPa2SiA6qG3
u0+WXtClKdIFUOkyWvAiQXNGuKI/9Q==
=WGEv
-----END PGP SIGNATURE-----

--crydygo6vpaqs2bx--

