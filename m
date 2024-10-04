Return-Path: <linux-pwm+bounces-3471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD829909FC
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF261F225FD
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E93E49D;
	Fri,  4 Oct 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ns/afgCf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56411E377D
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061842; cv=none; b=cT+GOOdjHuMSWh1y/E7If2kWKNKvj7/M8+t1wMdAlZ0COz8/txNml/iIXGr8OMO+niIxMMkTZP/PZAwnKw3dhgXvHy1GmZOEgGVmC8QnGTaZVSSQ+ttlBbuftSQvdvGitJST2Ca+E0xEEYxrqbdGpskgDpjMb8w0kA7Km5A4im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061842; c=relaxed/simple;
	bh=kHve5Iulzmrt50cLKVYWfm27OUouqIFvzHBZucbTJts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5wwa+fIHR7gCR4Q/lZtbN7h5J4UFjSBrxO9Ad9sLTQRqmKXkMTQ+xjeGONBq2FQM+ccVTlwHxnh2tPdPuq9xyTeQh7iL1PW0dciKVkFid+aQOli/urxi5z9OYl2oHUJRNanexijZ4Rb2t8WoFm8V0uIK+Nv2icwKApnWatCpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ns/afgCf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398b589032so3950502e87.1
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728061837; x=1728666637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHve5Iulzmrt50cLKVYWfm27OUouqIFvzHBZucbTJts=;
        b=ns/afgCfE8BM52W0Bbk2hRZNi9TiIGUntSYBytndiyYbSh86DsGT2cQwaEyNRfYnVd
         O3e9eFc+X/iGv5yBm/u2BtRuU/HyyodbTNYx96PpHJtr/nlWMIzZgN6nYolZ2dd9txEH
         GpaM4LndCq/3A8vxcqYtau1t0uxANsv0YDqNJhB3OB7bH3v27ISNQOBEONN357xfvuYr
         SmP5yGKyEg/1lGMZLbMHV57ClOjs9bNUk1vQlxNWDyN03O3rZJ88og3Gq6018Yy/7rNg
         c6VoAepKjM33DBILpq8DMRc9j99ArthwmFDyUIJIja/cZp8OpKLWHb+FrjvK+38mcJX/
         7WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061837; x=1728666637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHve5Iulzmrt50cLKVYWfm27OUouqIFvzHBZucbTJts=;
        b=OBGrhMQEImbsQFjO7VO5QV4/Yg4k1rFkMndprBEHsN8VTO5lkH+YMP23ulIGqSczHB
         onUngdBya0yGzKVzXh+mxmvUOBk4umlCIeeWF6wfi9y7q8/AmdlhXxIDDNI8kxgF4ofw
         7xXfP5YlVIHsm/MlX+Pg7Itvzd0eOtdfC/aowwtiW1dotxpNJhOhr4rXR/vVCE/74TW8
         pNOHBayT7o/c3Kmw+0LkAEdd/h5llIFfYNwwEqEA5v8KJKu4E/NlMLW34N7oLozOOOmQ
         6oUHo+b6fzZtiRK8EzJfrFhMB58OoLmHHd66WMBX/vuJFWKMfdKm1hPZ8LJfsWlP9oZh
         p0Nw==
X-Gm-Message-State: AOJu0YyQ1szNliPDcoL6OqRzccCLf2WdbuCo/QcpKMd9CsKjoQkIHoCF
	V6LuvLmh1l5Q3dOlMZr86TYextXeESFu3U4SHtcIjYaD9XitrT/OEllTKlrOz8MR3Gfz9LOkWiU
	E
X-Google-Smtp-Source: AGHT+IEuFVR0mrnYSkJTaMpLAHDKP+FJE9P/wmFk7ZJj7olNHsj9mOAbE+p5FZYXMsN2KPkSr6MY6A==
X-Received: by 2002:a05:6512:3c99:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-539ab868a71mr3361295e87.20.1728061836832;
        Fri, 04 Oct 2024 10:10:36 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b014esm17150166b.149.2024.10.04.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:10:36 -0700 (PDT)
Date: Fri, 4 Oct 2024 19:10:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Kees Bakker <kees@ijzerbout.nl>
Subject: Re: [PATCH] pwm: stm32: Fix error checking for a regmap_read() call
Message-ID: <ez67nx4vvztldsmizx5jav3aebo7vldz5p47ccejtiuibxtikt@kgv632vgn7ji>
References: <20241003114216.163715-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzntg346lltwsphp"
Content-Disposition: inline
In-Reply-To: <20241003114216.163715-2-u.kleine-koenig@baylibre.com>


--zzntg346lltwsphp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 03, 2024 at 01:42:17PM +0200, Uwe Kleine-K=F6nig wrote:
> Without first assigning ret, it always evaluates to zero because
> otherwise this code isn't reached. So assign the return code of
> regmap_read() to ret to make the following error path do something.
>=20
> This issue was spotted by Coverity.
>=20
> Reported-by: Kees Bakker <kees@ijzerbout.nl>
> Link: https://lore.kernel.org/linux-pwm/b0199625-9dbb-414b-8948-26ad86fd2=
740@ijzerbout.nl
> Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callback=
s")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--zzntg346lltwsphp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcAIYgACgkQj4D7WH0S
/k5XGwf+NOFvdVivwkJ0MOynmGWm/DVF4o6lD8o9z5RmcMK89v83s5GfHvvudkXQ
4mKs+CgFNSsJJWLOnA24XjM7m8JjBQl7XJDHhLgUDU11sTed3oGD5RuBF7SegGuJ
6/yMM/XLuLRo7UU/X2hEZ2bcFj2+s4JCYGflYG5Igts6eAq4Vc5DGanL9LwO7KWo
9JKg8P7/GShlU5sF/c5ELaHXLE9dOhy+qjBlheVDKC2MepHfOSsooq4YV55V/rnX
dZAuxxScIxRiGaWQal2q01aiKfBwn/SQa+1XZxCsCfZgqZVwX/dW+BbyMeP5d6PZ
hEjwIgeKWRv7PNmtpZXtNfcIVaRqnQ==
=XQue
-----END PGP SIGNATURE-----

--zzntg346lltwsphp--

