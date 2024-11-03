Return-Path: <linux-pwm+bounces-4017-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744679BA7E1
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10752B20EBC
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4318B49D;
	Sun,  3 Nov 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z5tmOAc0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0B15E5CA
	for <linux-pwm@vger.kernel.org>; Sun,  3 Nov 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665249; cv=none; b=jVTlCF3MSaI63QSjPXW6xTNfcj5BdywjQMQzK0Gkvrk0GzF+dFXx9t16837vj58hK8eouo0jdRKqXtj6B7CjzYfL8LeZu7bLB3zacrpH8VMxvTyOBlGZOxERUPLndRK2v23m1AZmoURXFET5to5BWVivQEwlzLQu7owASS2mfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665249; c=relaxed/simple;
	bh=0zoz5lm1V6JN5CFOkg53xcxKckUvGgvBhj7EMYnnUzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozSfAYx6+IwzV1hAan7lv6K4DFyaFPe5k25zI1pu18GJpzaipuy8804MAto3ypMSbRr6xpEv5GNV7CzCUdJN0GjZC2tFVRYy1bgyFARLbvnfaIyytGOjt5p2TtKwcKN9fIsHOiwfk14SMC/c+BGksk+xZDtAwu1I93BFApKRsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z5tmOAc0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cebcf96fabso2538501a12.3
        for <linux-pwm@vger.kernel.org>; Sun, 03 Nov 2024 12:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730665245; x=1731270045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zp4YtXuSexn4oBzrN9Y8dVklYvGXzwQ+TOitGbf9SkE=;
        b=z5tmOAc090s0kPeiDxnkmFhXW5Jf9maBTEID8du/BuEbrkHbkP7X46J1cbP2LxrMe7
         5UP4ZdLZASnacZ63kzwmoVLF6ADRAudSHnO0fizGZEgMP+pOgVkW8qKf8ii8MpVZ9khC
         xYMaq7UJ2M6T65RWPhGBdxdYcVlvvqA4kvOG7exd02CNUnfrd26nhtGwURm3TW3lhcIc
         F3+uzbonBV1PEols+BZrFIPLh9ETz4pr0qyjhLMYRF3fIGO8SqL8JRFVwKF1QLwa7h7E
         HVzIsMaeHjDaf6kcV2saA8sHfsdtUOr8myBKec3KO+Y+q/OdN71gPC+pR9Tgbon7qtMh
         cKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730665245; x=1731270045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp4YtXuSexn4oBzrN9Y8dVklYvGXzwQ+TOitGbf9SkE=;
        b=Q0Yua6HdufPOA7g4J2j9ZZTNywJ53T1cnBzkt9W64Q3AApY+8vnIJDpzhLRt02gKBv
         kf+SrP+Pi2Z4CrquBrB2c1/CcT8Eborv5xddpYWgXcEyl53FsH0Vfgyo09ZFEDEDBDyT
         KqpMtawT6Pt0/9X53nJR6n0eeMCixctQemSaaBa2sZfY7Io38pgBfza3aSBZY6qs7akg
         sOxGYsLVlNpzbwP5UrgNLn+QBQE3OBU02tpRBhWsiLwptjlO9xxhmksrmBsGEbwUzgrp
         v+yflW1ZbsNGc7SvCRGIw8JL9N/63th8sIjnrfc73/sNvYb2EdBz4m6ClPOE+U7ppEuo
         6XoA==
X-Forwarded-Encrypted: i=1; AJvYcCV1q9/dzpqnvw7Ubbcf0gvgUvCz5BqDGnlSlTJlURx0he3SJ68yNpTW6BJ/2YQ1KQHFHO3JJi1PEFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaO4WfoWvSfvGm0RvKCdUcHeC6WLxg8Sd25TJs/chfAKo8q6PY
	Qv3X2V0r9/okh3FGHxOkaZuu7Djal/E7eND/h3kJ/WhzegBA5PUPHBKkl0dmHCY=
X-Google-Smtp-Source: AGHT+IERawzdo8mdjAZRJEgHt5N6dGAKA+wUD+Xe4d/NURkOTWW3DdQKRBXsu7LEK76VCRW3HpCjkg==
X-Received: by 2002:a05:6402:270e:b0:5ce:dd11:6244 with SMTP id 4fb4d7f45d1cf-5cedd11630cmr597417a12.32.1730665245259;
        Sun, 03 Nov 2024 12:20:45 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:711f:c21d:28dc:9f01])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac77015esm3548592a12.23.2024.11.03.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:20:43 -0800 (PST)
Date: Sun, 3 Nov 2024 21:20:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Guillaume Stols <gstols@baylibre.com>, oe-kbuild-all@lists.linux.dev, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <awpjqzq2ksbqvlfkbh4xnpwqxrnf4np6amifdweasrh52v3jl3@lz3md7ydyhji>
References: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
 <202411020101.5Hs6MkwQ-lkp@intel.com>
 <d44ab5s73kmochmwis3buhd6ci7ff4rwd7kgh47aqar6xeyqna@f4plwf6qbvlm>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brypaa3fkyl5s5wz"
Content-Disposition: inline
In-Reply-To: <d44ab5s73kmochmwis3buhd6ci7ff4rwd7kgh47aqar6xeyqna@f4plwf6qbvlm>


--brypaa3fkyl5s5wz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
MIME-Version: 1.0

On Sun, Nov 03, 2024 at 03:00:14PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello David,
>=20
> On Sat, Nov 02, 2024 at 01:50:35AM +0800, kernel test robot wrote:
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/pw=
m-core-export-pwm_get_state_hw/20241030-052134
> > base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
> > patch link:    https://lore.kernel.org/r/20241029-pwm-export-pwm_get_st=
ate_hw-v2-2-03ba063a3230%40baylibre.com
> > patch subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw=
() TODO
> > config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/a=
rchive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411020101.5Hs6MkwQ-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    drivers/iio/adc/ad7606.c: In function 'ad7606_read_raw':
> > >> drivers/iio/adc/ad7606.c:765:23: error: implicit declaration of func=
tion 'pwm_get_state_hw'; did you mean 'pwm_get_state'? [-Werror=3Dimplicit-=
function-declaration]
> >      765 |                 ret =3D pwm_get_state_hw(st->cnvst_pwm, &cnv=
st_pwm_state);
> >          |                       ^~~~~~~~~~~~~~~~
> >          |                       pwm_get_state
> >    cc1: some warnings being treated as errors
>=20
> The problem here is that there is no declaration (and implementation) of
> pwm_get_state_hw() with CONFIG_PWM=3Dn. Does it make sense to enable the
> ad7606 driver without enabling PWM support? If yes, we should add a
> dummy implementation of pwm_get_state_hw(), if not, a depends on PWM
> should be introduced.

Looking at the driver, the PWM is optional. So I rewrote the commit from
patch 1/2 in this series and added a dummy.

Best regards
Uwe

--brypaa3fkyl5s5wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcn2xcACgkQj4D7WH0S
/k6qGwf+PRPPjDTaPe2Qq2XZE5P9C3PLoXwH95RnwAf/b+F/pZAYoH5F1SadS/o8
Jg7TDfoA+w7Zqca+t9Q7rnheds6dlQk5b2Z8sxglqjnguD3zSXniYbmsZTM+dIrk
uNRFgxf/1mRaTQsy9y9N7TmJcTdxSelLX0mBhYMAzk3RejZQbF9xjWDr1HhtQjkg
Ulve7uX6Cx+/MqaN78w/mUgnXifuZvwQdohOHznn/hyVAW4+emkcTGtQqBvCyl6C
FWWz4N1qd9+G3dblWDB3WsKAUO04wq/B/I/O66VThD4IU+uz1SL2GqQ5CI0Daefw
woJYAQpnylt82oWds3lAKJW00hfN3w==
=VNtb
-----END PGP SIGNATURE-----

--brypaa3fkyl5s5wz--

