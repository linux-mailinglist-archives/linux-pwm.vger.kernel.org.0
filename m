Return-Path: <linux-pwm+bounces-5692-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72FA9B0D8
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0814A5F59
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5B19DF4A;
	Thu, 24 Apr 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KvdcQlGz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B419D890
	for <linux-pwm@vger.kernel.org>; Thu, 24 Apr 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504459; cv=none; b=gs+wQogyvy34x5dzFJRDKoE886MBp9ppBXVxEtihtf2iegOwecUM4FyJYk5CTCYofjEGgLleYfkzaEL6INFeiZhSvyX5whv3ZtduMfM7z1WXtVnD9NQnJd8VfJKi6Z8xZBvsnVHzGzV+VKiXgkcGvyxEGnYN8eELau5QrxRWlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504459; c=relaxed/simple;
	bh=WLEuRIFmXAgSCoXwPbpAq78UHblyo1i/FyTc3h4Bng0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZAt+SgpyqvB23996wV7D+iBFyS3BydS+trXbIGexudJ0xMzJbkfgzZC+KmC3ha6if8kfe8t7we5vXQxqvD3JaEgkrPuxH1ti2qDHPNBPtjXu/heiOyCgVgBPHxhn7YmwJvXROg9Bjqwi/RRhDr0pRi7SEl/LgHkFd0jVZSW16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KvdcQlGz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso11057915e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 24 Apr 2025 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745504453; x=1746109253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1deKK5SRe/4fShyvMGoXdhp1vcO/LNHkR3cWwM0oOM=;
        b=KvdcQlGzo/UP9cC5YQ0xKmpDKL6tMaHD7d9cdKbPAvKsgMV9pB9qf1AgJHCv4SsP39
         iw0CsucnEyfEiQ5eOodUAKeUWbrjjT2x9lSbgXmisoCfyCn3g56lVsK41LEGibsyY3RK
         EIB98oBlVLjF386Q6K4e0lONnd7Jqp5lKiPrrCNE2bkHTQCTXQXxre/C2PHCqTPeJ2Ji
         pg96B1SbuGIf27zqIVg/PJOgq3f27Zk3+qcQjbFDQo589ClntSSlezbwt14zlrWYyjh0
         qKD/HGAg3HhTqtIdlD2TnPLLuuNJud0ZHqa8aT13BYBHN8hCYGTwdEWu2EImqn5KHdQC
         uAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504453; x=1746109253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1deKK5SRe/4fShyvMGoXdhp1vcO/LNHkR3cWwM0oOM=;
        b=KPifm+ktrZrC2iT1EDvvwLJYYxSf111UePjBKW8+/7DOnL5wYKM9Km9AUtvQYe2ZWi
         fjIE8sEvMABReF+Q8vLDVugfjIG145/uqjJe1ZBvhDrRCTT0or+dsst58dYydzMXChCx
         jn2eCgZepqSSpsUeNsrjlR7E7Dkx1MSeo2h6dHTeHMPfAABkskK4eT0xZQ7suUy9yI15
         zRdxtga5ZD3Y3Bi514tObP9as70tKM7GA9JqhyYaxXAr82IkbGrl/z5XeMi7FwJwRUeE
         FitPddzV6oEL2L+LqmgliLI6nbkMgkHu+UEy5SteO7uj+WNgS/y3wJjJ9dJhaKjKhnxK
         vk/g==
X-Gm-Message-State: AOJu0Yz6/NdD/jWYGhNsP205yYtyXvINExVwXu6VKFCZXk58lRraRybr
	gVlrt/t4QCwhIuO+Hol+5JQv68qMgg37hYW7/1LigI6AlUuyTCHbHGaFB5LDgb+Fv+ekRqdzlm5
	I
X-Gm-Gg: ASbGnctTxZT5QdGOX3leFYH9qgr3s/Wt4j/I/LhsSKGMZplzIASj7/tbclVvoTx3nQ+
	ea04aMisuoOuXVncKPzDehoHoYRUgMJb+UfzkTSJLZqzuYZSBUfpuG1plQOOgV+gn5BtbDJnPiF
	On9jYcD0Vv+gE6QqFTUC3M8hEu5EzNs2KsPLx+nogHukzSlIWlQwn5k+g5myzDH3IVaMN/CNXq/
	qn8peXTCABkRP8QYk6zQftcIgFjJSpdy6/v8eX1AyxI/sZ9Xt2Q4HXvE8owm87gXZI2corfSeyZ
	U4sPJxSXZn2THtfbOy5KSIu4kALozDlhZmCSiImuGvRa4wqFAI/lh8O7i2+4lcEhnQ0meQk6XNi
	Rw4M6L70=
X-Google-Smtp-Source: AGHT+IHvLwXwIH3+cH+CBObtIhBz5QDOyfBBcuqCqb5aQivN766NDrVPvSC26ozjO3kRrthafuxshQ==
X-Received: by 2002:a05:6000:1a8c:b0:39e:e259:91dd with SMTP id ffacd0b85a97d-3a06cf54648mr2491993f8f.17.1745504453247;
        Thu, 24 Apr 2025 07:20:53 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a06d54c092sm2251065f8f.87.2025.04.24.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:20:52 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:20:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Fix various formatting issues in kernel-doc
Message-ID: <2qg536k7rm3lcusftgsf3qzvejgjvsdc4khwr23z32zoqnqjnn@eyk4gcmeahlh>
References: <20250417181611.2693599-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxtrv5dhelhz7inx"
Content-Disposition: inline
In-Reply-To: <20250417181611.2693599-2-u.kleine-koenig@baylibre.com>


--gxtrv5dhelhz7inx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Fix various formatting issues in kernel-doc
MIME-Version: 1.0

On Thu, Apr 17, 2025 at 08:16:11PM +0200, Uwe Kleine-K=F6nig wrote:
> Add Return and (where interesting) Context sections, fix some formatting
> and drop documenting the internal function __pwm_apply().
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I found a few more things that are rendered non-optimal. To reduce the
noise I will squash the following change in the original commit and not
create a very similar second patch:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 70ec6430edfe..e0a90c4cd723 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -216,8 +216,8 @@ static int __pwm_write_waveform(struct pwm_chip *chip, =
struct pwm_device *pwm, c
  *
  * Typically a given waveform cannot be implemented exactly by hardware, e=
=2Eg.
  * because hardware only supports coarse period resolution or no duty_offs=
et.
- * This function returns the actually implemented waveform if you pass wf =
to
- * pwm_set_waveform_might_sleep now.
+ * This function returns the actually implemented waveform if you pass @wf=
 to
+ * pwm_set_waveform_might_sleep() now.
  *
  * Note however that the world doesn't stop turning when you call it, so w=
hen
  * doing::
@@ -403,13 +403,13 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
  *
  * Typically a requested waveform cannot be implemented exactly, e.g. beca=
use
  * you requested .period_length_ns =3D 100 ns, but the hardware can only s=
et
- * periods that are a multiple of 8.5 ns. With that hardware passing exact=
 =3D
+ * periods that are a multiple of 8.5 ns. With that hardware passing @exac=
t =3D
  * true results in pwm_set_waveform_might_sleep() failing and returning 1.=
 If
- * exact =3D false you get a period of 93.5 ns (i.e. the biggest period no=
t bigger
+ * @exact =3D false you get a period of 93.5 ns (i.e. the biggest period n=
ot bigger
  * than the requested value).
- * Note that even with exact =3D true, some rounding by less than 1 is
+ * Note that even with @exact =3D true, some rounding by less than 1 ns is
  * possible/needed. In the above example requesting .period_length_ns =3D =
94 and
- * exact =3D true, you get the hardware configured with period =3D 93.5 ns.
+ * @exact =3D true, you get the hardware configured with period =3D 93.5 n=
s.
  *
  * Returns: 0 on success, 1 if was rounded up (if !@exact) or no perfect m=
atch was
  * possible (if @exact), or a negative errno

Best regards
Uwe

--gxtrv5dhelhz7inx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgKSL8ACgkQj4D7WH0S
/k51uwgAuaGzRCu6X5Rr/3inHC8PPaRbg2QcIABQhjZnyE2l6+UdG+Vh6jeFKTeZ
PyOsYiY4JQq1g9q1omGduTviqWYwOqGgV1NRkCXIMEJKmo0VwcFC9Ui6mpzIMMsr
Xn1XhJeupg7q4VJ811/rkYsew6KIJUSSNzd/D+NaJGZK+yxCkA6fZruMPQvWw6DY
QiXTad4qbum7go5MsVOt9wCvRrOpfPXaqaOrM3Et7OZNQgFGf3bOdNcTLpDcDZ90
WMXe6gctHP8apNFlAfXq0STOhQwLVEVlhRRTh8FExGmWmiFRNgVWQHaCCZlfdpwq
Ag7W2qVuyeNVDUXdIo1aA5ss4J2vuQ==
=iytt
-----END PGP SIGNATURE-----

--gxtrv5dhelhz7inx--

