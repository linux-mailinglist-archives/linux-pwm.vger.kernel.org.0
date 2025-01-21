Return-Path: <linux-pwm+bounces-4696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A3A184E6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 19:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8952160C59
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284A1F76B5;
	Tue, 21 Jan 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X+tf+EK3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402651F76AE
	for <linux-pwm@vger.kernel.org>; Tue, 21 Jan 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483136; cv=none; b=pz611tdGi5o4Jmckv6yHhTkLF0/sPw3cMob467CudZ1ugW1RCfT1L6VczHoax9nvLbdjfAuZq1GWPWCWm+Fi+Xt87uFvAxM8MsGttBS5RTLtGJE5ggcymlNZgmz7ODVB8xsjFtUDBMHoj7UMCzLYGRUULDvCOPjT/ROEJMCZBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483136; c=relaxed/simple;
	bh=PX4CTXKAk+6wuzMo9LV9c/ouzv9PEXO3gBah07BHcio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzpNGiOIo+O2s5SM8PXi0FCzG0ELBjRxPgysJw/phbKklug1hwOJZ6PCqQCwrKHzjhaKBjQ8GAX8W92CeTI8cemKj+1F305vovPVXDnqVK1yis6gWO9WikSg4MqNjlVAXZ0VgRaPmlvehIBSsN4CEqU0Gjr/swkrNesZMmSdZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X+tf+EK3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3160643f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 Jan 2025 10:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737483132; x=1738087932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ATWl2w60Z+sGkeI0mcnx/4T0KHdRkIjZ8D4tZCsI0Y=;
        b=X+tf+EK3knJ5p60Neoj7nNQ/3szr5Mj537nBOUF5Ij8Q9F/doWtzQgE8xfd8vaqxJ2
         7n3Mkz9T0eobQMhD/vq+lqcWp6sQ3pxtvnQoACmEx22K5gWP26iPKwZ3taYrLo4cJ+gt
         UNi+RYt9j2yDUK+Psy03ajprNoeStIKEJ2wdsYO+QVvGwwEyVqSJxvyZVYa62zgoMuIi
         OI650S1L5tz9Q0IdVoogtiOJc3C2cd2J7f46DqHRZu5JD+4lTXDY8wg+X5nWmRe4IvjR
         XkI4KH6sRPwWrgtxT3U7IEkOyli6EVb6YvASPQr1R8wG5mgOVt0IfjW/TgysFXIWn0PU
         SC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737483132; x=1738087932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ATWl2w60Z+sGkeI0mcnx/4T0KHdRkIjZ8D4tZCsI0Y=;
        b=Q9NJzN5Hv/KUBqnaS251If7f1Fpccvv1HyJjZ2G/LReqDb6fc4x11svyrSUtgryZUq
         YphwId8B3A1FsXjZL7IuAJFUJzNzWc7uNXrV7cCzpbn4U/iG0NbU171R4FsxBW+PFgpX
         onXfwpdUYAa7PhrO0mBjLnqWJdmtKy2OMn/CuwkMx7VS2erqSyJelLcx8NHcJim3vM2f
         gVISNqtMoPgncCL85gFYcjnJrpQUCnNa0dyEGGCrD0kU3+zQDYerYuUQ8Kj18XPybty+
         6oxHrEbXgeCUukaIgoXSRZWJ4SfZdCqs6E1CGlJ3qiWKczRtD6yEx+3cez1sNsAhnZzc
         5y2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR216RxnHBDQjpm5dr+aKau/Myh4GeovKBoKQSK6WL9q+J0nmiBtvI3ZlfRuPWnt/XBsXfpIWRwEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaShKQFSy3nzDn2u6bndz8aAGTm35KOWMr9G9JhbWyPBE3MRPp
	XCONxR0FOCof9l8FqyLcrN81kfPmMmxEO1X48oc5cFysmsyqUWrmwGU9xUTtnhg=
X-Gm-Gg: ASbGncv4HQlV09DO5sn2iSRkJwiIhFXbUfHpYfEtYEvLVi4xMc7WLphYyYe0r4a/MKe
	9W1xQv83BwZsMhaiZZxFJZbyJpKo8uJgjLrzFEC1iNkcfBDRBX9V06DuQrRdvn51g0W9y20h88q
	PalcHFUWC8LpB3wTg0OliDoi3LgP9YRqLRTh/CCvx9k7p0OMFW+wVkbSdaTjlgcee8TMZaLNl5d
	ZhF4te7hO38rIV0/cVazwlYx6YQS8nc4+yOXnKIrIztlnHNDxWeMqZE+t4QdOA2QB/znQSm8Ol3
	IeWNisEVK/xKYlyGH/ALRst5Rkh3dPA6TAax
X-Google-Smtp-Source: AGHT+IEjt4N7MJCEhKaZiHurWidGu495CgMG2Na/7KPIXm7oitJAqBfxZ0jP9XuVkrg802ep53//rQ==
X-Received: by 2002:a5d:6c6f:0:b0:385:f3fb:46aa with SMTP id ffacd0b85a97d-38bf57a91acmr17612253f8f.43.1737483132532;
        Tue, 21 Jan 2025 10:12:12 -0800 (PST)
Received: from localhost (p200300f65f0afb0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f0a:fb04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321537dsm14275228f8f.13.2025.01.21.10.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 10:12:12 -0800 (PST)
Date: Tue, 21 Jan 2025 19:12:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <7bcnckef23w6g47ll5l3bktygedrcfvr7fk3qjuq2swtoffhec@zs4w4tuh6qvm>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
 <CAHh=Yk-TosOmwEughfK9mMx-=DgzWK5H_bf6H641SGh1ue8BrA@mail.gmail.com>
 <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
 <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5j2h6qzt3k55kxw2"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>


--5j2h6qzt3k55kxw2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

On Tue, Jan 21, 2025 at 04:47:46PM +0800, Nylon Chen wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=B9=
=B41=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:47=E5=AF=AB=
=E9=81=93=EF=BC=9A
> >
> > Hello,
> >
> > On Sun, Jan 19, 2025 at 03:03:16PM +0800, Nylon Chen wrote:
> > > I ran some basic tests by changing the period and duty cycle in both
> > > decreasing and increasing sequences (see the script below).
> >
> > What is clk_get_rate(ddata->clk) for you?
> 130 MHz

OK, so the possible period lengths are

	(1 << (16 + scale)) / (130 MHz)

for scale in [0, .. 15], right? That's

	2^scale * 504123.07692307694 ns

So testing period in the range between 5000 ns and 15000 ns isn't
sensible? Did I get something wrong? If the above is right, switching
between period=3D1008246 ns and 1008247 ns is likely to trigger a
warning.

Maybe also something like

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7e863c2cd44b..6c82aca84472 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2247,9 +2247,10 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
=20
 	for (i =3D 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm =3D &chip->pwms[i];
-		struct pwm_state state;
+		struct pwm_state state, hwstate;
=20
 		pwm_get_state(pwm, &state);
+		pwm_get_state_hw(pwm, &hwstate);
=20
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
=20
@@ -2259,8 +2260,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struc=
t seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
=20
-		seq_printf(s, " period: %llu ns", state.period);
-		seq_printf(s, " duty: %llu ns", state.duty_cycle);
+		seq_printf(s, " period: %llu (%llu) ns", state.period, hwstate.period);
+		seq_printf(s, " duty: %llu (%llu) ns", state.duty_cycle, hwstate.duty_cy=
cle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
=20

is useful for debugging to see what is actually implemented for a given
request.

Having said that, I don't like struct pwm_sifive_ddata::real_period and
pwm_sifive_ddata::approx_period. These complicate the calculation and
=2Eget_state should better calculate the period instead of just sticking
to ddata->real_period.

Best regards
Uwe

--5j2h6qzt3k55kxw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeP43gACgkQj4D7WH0S
/k5jDwf/Z8ZyPbdZfE5yI1ZGDLTJiKlqXt2/IGKvjygXoU5XWSqpR+NzbQOOBVOG
shlMIS3QeyzfpmSnM+/sSIoFViagCMioQjmkSIBzr2Eg/vsaHGzm3YhuLL9UQNC7
Cz7N1NgR77RWyRYmVXBnrYpOhJ6TZkGo0cyFOANh5geMBJmT+MBCnzTSRLqux0rf
Yqe8N4Xpg3KEpzbM9W0QflCOlvmpL+cgy9a/omhpb4hdn407p52Ce9UYHs+V9OfK
Fy9PKP7KzcwKPOBH2eXosK6ifpAOAxmCQrWSkKsyO8oqZDR89jancE7VMKEvqeNd
uYSjdmRNxlJgFtRL2P/w7KCoRysVoA==
=hiTK
-----END PGP SIGNATURE-----

--5j2h6qzt3k55kxw2--

