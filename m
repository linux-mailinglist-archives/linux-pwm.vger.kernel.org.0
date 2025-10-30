Return-Path: <linux-pwm+bounces-7567-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04600C228E4
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 23:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28824188505C
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2633B6C5;
	Thu, 30 Oct 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O6Uu9CIw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD22EA172
	for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863317; cv=none; b=hApFWhXfrALJHApgBqP1LcNEsu50xk+HGscOpP/YjwnguipbQDKDkv7rrRkR/IOylsy2CzANn+4erUmjE/W0k63KXQbbl+xh+reDqKf9+pTGIJQ7S6Fm8mX9Y2tkB+Rj3kycbIjxUchFrGCWCPTehKOFV2FeSvgS52+KJIWWV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863317; c=relaxed/simple;
	bh=yLIj2ZxzmymqRauTGMy4XKLZHvUw1c2JZBXJt76wks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2iNA9AUaNv42IpThP/kt3zbKmi3zcqx7JZ6IHmS26XBXGSscpGd4UlrAzzAQotHbejpYxYqjGJuHJ5c6YUDoesl3hKuDu7MivcX5urYnrUvTanWoidXRrOF58NnDfllsLLIHb8Eeja45GH4toj8wRaK6iHJtAg/IwdTFQu6e+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O6Uu9CIw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso3341881a12.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761863314; x=1762468114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLIj2ZxzmymqRauTGMy4XKLZHvUw1c2JZBXJt76wks0=;
        b=O6Uu9CIwUNFanCxt+JmMUiSrv/7u7q32zciqAdTlUPtsAVno/ljolxacI/Ib8NzpUr
         9US6vZnZ6PMva1IWUuq8SsDOWfHO+15XkHuSqUsoFgRd4h3ietXjTIUNWN54vbEGspvD
         5BijrMh8MQbGYgX5be9wkEthQtgcUAONOIUCtLDCzayby5O565iF9d+TMxlBESyoKn/+
         rT2HBipLkto9bAVmwVYIM8lrpSzeerhyZfnE0s7mwY9AEyQVObsU5+NAea4nu6QZeIdN
         WLbFV44WP7tBMR5jvtazb/LND/YSLYVqiTQRS1BMgSy2d4+9i1xf/Qy0piBGOes08LF9
         p9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863314; x=1762468114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLIj2ZxzmymqRauTGMy4XKLZHvUw1c2JZBXJt76wks0=;
        b=am9vsRViNCs4QM8ncVyvAKaG21B/r1FCuQp5PruHsTVbLSGlbhISl713cT+yNztkfH
         kI+5djOkrY2X3rufmkqsWDa9ozojtcAS812nP/qUFnP7aq5fEXvsrtSt25RMAqoAajwY
         oWoHiWMwG2Nn+eIf/pdJMiRols1ftT7yIFUNhBEVy7ei+NvPzILiONYrOMsUqiEc8WvQ
         3pYaugq2viJuD5t261De+IItgTAnmJIefVjyM/mItOFnDO/d6RIE93T1UZJS/zFRXsvX
         mU4heLYnS0S/0X0YWlZpAbROLmPwgrVj+yPPSpcnKC9DFTutgRvRRpNnNzytW7xDK80D
         P6tw==
X-Gm-Message-State: AOJu0Yz1nxXAeTl3MxxWF5zVDKqiy2mupTqJQzx9uVooSEt7lc9OZrmh
	TyzPBVJIuZXBcRt+S0qKSnYvR0gRpLvI0hAO9RMT41AtpUZlyqzRzMxjXTz86H0uGXw=
X-Gm-Gg: ASbGncu7gF7Tp5FEqP9flpIj46nHoxnDL/rgUc2eB7yf1O6CDoTT53yWYgntv3OkXg7
	xKxBFvSfZrGQunNLYO48ktkgo1xDzF5gZc2Se5dPBVydcH/0niJj6N2UcCIOqQjm5YIlWJ5PtNN
	kWOasFdhKfOc+CsLnM4ukH8YWqzXN4Xl8QdSqrEjgrf+FvfCuE8FjABYMPDtZxm54USle2tVQVt
	SGaPLwAUYl4OTYDlWiZRzlJ62in1hamOZnzO4oSFj0Aqhl8a5He5sd9+6BEIgN4TX4ZnbTInLCU
	Q9mBEreTye8NAAEzj51stIa74F+MMVmuAf3LaWoYufbHFN6SWWIeiy3r8fx02SNA865bDf/ybzJ
	egjiwe/VQRfeE9WG+WakoyKSZP/IAJH4bynP2I5O5F1SQRz6frkVH1eSFB5qrzknPpJ6Z/zH4kW
	W08ZvHiw==
X-Google-Smtp-Source: AGHT+IHJSQvJu6sueJxCiUL+EQWJpzwZ/WTHJR+xaALkyTaBAgSDfM7hwfeK84Q5Re4DmoCk0CX88Q==
X-Received: by 2002:a05:6402:440d:b0:639:f7b5:9c2d with SMTP id 4fb4d7f45d1cf-6407704f19cmr962096a12.9.1761863312684;
        Thu, 30 Oct 2025 15:28:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6407b439363sm86845a12.32.2025.10.30.15.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:28:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:28:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] pwm: mediatek: Convert to waveform API
Message-ID: <4lhh35sxh7dkmn6iqpje3zojea4qqc64nes2npkuxgqsucusah@sclwr7uokzq5>
References: <20251013114258.149260-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmymtir4yxpkn2ip"
Content-Disposition: inline
In-Reply-To: <20251013114258.149260-2-u.kleine-koenig@baylibre.com>


--rmymtir4yxpkn2ip
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: mediatek: Convert to waveform API
MIME-Version: 1.0

Hello,

On Mon, Oct 13, 2025 at 01:42:56PM +0200, Uwe Kleine-K=F6nig wrote:
> Implement the new waveform callbacks which makes the usage of this
> hardware more flexible and allows to use it via the pwm character
> device.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--rmymtir4yxpkn2ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkD5owACgkQj4D7WH0S
/k7yEAgAoj8oyEvLV8k3Yq3Ir8m5016o/vQbhThpW9TRHRhr5SKtxVfa07ZM7yWC
Aho8ZW2AwOIuNRnr6bUs2k5O/lSg0UBZU7TMY8AVXbfBF8hj6bcoNWbV3LD9oGTC
3B37fW+mlwT61d8Op6o4r9aO0zO9sQgMcyUbGSCiHWasEaD14xnCFGpHP2aTwoJG
WSC635SJj7uTVzsuWFAdf3QQNR7CLCVSuMn4ko6mYtGevLy8xapCfMOfdlQXEHMA
GpOj+H+G57dNpleEGxa6QSMoQ1uMwyCPC5tIAIgJ40xjIfViQBuQAOF7BwXZXPYs
8oKuk9iEEHkCM8kcKPSZCoCKcRgaXg==
=0ccV
-----END PGP SIGNATURE-----

--rmymtir4yxpkn2ip--

