Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8C343B13
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 08:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCVH6x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVH6W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 03:58:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F08EC061574;
        Mon, 22 Mar 2021 00:58:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v4so15569125wrp.13;
        Mon, 22 Mar 2021 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JczHixNLMGj+es6FQsJTPDKyju/gYUNcBlGk8mzUgzI=;
        b=BWL4mbDoCPbbfrcLKVWe742Sf4A07uSbX4fxbgF1cDD6oup5/1WksuKn8NClA9AO2+
         QioT6Y+pilkav3CsvyHHSrvy7hPNi5w4cH2iUxfV916967kZlYfck0b/+QMp+MzSUo6n
         rwJ+2sEHn2Bh1Wwfyp18mQskKqRT9nPAFmDxJMPA4pGoFQpdcUaY1pDDxvuTvNySWbY/
         J+4LIo/abWbuE8j3nHlixJH/SQUf1VUdWVGY5E0h8f2yCr9zNhcELZ+6L9wm+faL24Fc
         mfEw6Jcdbmy7t74VH5refE9XxyJ8DjPQsWKBUunyDZw20dfXwct6ABA2O9yqDOwjWIeS
         a8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JczHixNLMGj+es6FQsJTPDKyju/gYUNcBlGk8mzUgzI=;
        b=H9RHFSzvZFMRfEnCCKyzF/vW4J8OlKC1NuvRFNhl8xnUbUTneKI0B5pVO32elHo+Ei
         4sGNU1sfIqXg5Jv4ifZbE/xGCuVBwVusQoHkH1knAWJlBEpH9D8wwkOoKIN/cD9wmvAh
         bmbZmJnaM58oNx+ZlQXsuYqYqlgea3RFGnNvZcRAWrtMV2l1ybvkmZ+XadWamB4910CS
         H+0760L2NvX5cuIHBnwSAyolrWWXcZ15vBMdY7oEUaOdXgdTXr9bhZUl8rXDY1PTS2D4
         6PehBlqofhJS3YCbJGslYaCIdP3HNo1z79b5DBtTnYgaLLXj+XVRXAFaBssdE2SlW8Er
         POLg==
X-Gm-Message-State: AOAM533+5Amz4WXQ3banhdJLRN4CvkEjNa71WEviI4ajCU3R58T9ggWe
        tF492InDHLL70ANdpY17iO0=
X-Google-Smtp-Source: ABdhPJwD8vNjq8nVLUp/3Ph2pGld0s8h/EbcNSasYnh2Klc6oOhuUxxPGIBk4LeUpPltA6qM05I6xg==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr14475951wri.90.1616399899111;
        Mon, 22 Mar 2021 00:58:19 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q4sm16007653wma.20.2021.03.22.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:58:17 -0700 (PDT)
Date:   Mon, 22 Mar 2021 08:58:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <YFhOK7YuOtTI+gfa@orome.fritz.box>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com>
 <X9uL13GA1uDbLJiG@workstation.tuxnet>
 <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="41IcEhGcM6XGCGcU"
Content-Disposition: inline
In-Reply-To: <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--41IcEhGcM6XGCGcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 12:10:10PM -0500, Sven Van Asbroeck wrote:
> On Thu, Dec 17, 2020 at 11:48 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > I can initialize the values to 0 of course and check the file for other
> > places with missing initializations.
> >
> > Or would it be better to check the return codes of regmap_read/write in
> > such cases? I'm not sure.
>=20
> I think that checking the regmap_read/write return values is overkill
> in this driver. These functions can't realistically fail, except if the i=
2c
> bus is bad, i.e. h/w failure or intermittency. And that's an externality
> which I believe we can ignore.

I think there are (rare) occasions where it's fine to not check for
errors, i.e. if you definitively know that calls can't fail. However,
given that this uses regmap and you don't really know what's backing
this, I think it's always better to err on the side of caution and
properly check the return values.

The fact that this can be externally caused is actually a reason why
we shouldn't be ignoring any errors. If there's a chip that's hogging
the I2C bus or if you've even just mistyped the I2C client's address
in DT, it's better if the PWM driver tells you with an error message
than if it is silently ignoring the errors and keeps you guessing at
why the PWM isn't behaving the way it should.

Granted, the error code isn't always going to pinpoint exactly what's
going wrong, but for serious errors often the I2C bus driver will let
you know with an extra error message. However, it's much easier to go
looking for that error message if the PWM driver lets you know that
something went wrong.

Please just add full checking of regmap operations.

Thierry

--41IcEhGcM6XGCGcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYTigACgkQ3SOs138+
s6EZZA/9HXIKvPJZRGitdRoOS8/DxFIp1cj14qpTGMCCTsWsPXNqQ6KrpZczn3Pk
+3MlE3rvl6K9EDgNLDywsN5FaQ+HRJp7wdWUZOaH099uB/t+jIj4EDFU7WfzZYiO
Lj4D2h21zYnKNqhzjb6Xukv36Ym4Xob01sa66N2LL/JoOCUBtvZrkcDFlO5fCuTO
TAEklnpFdfYyYrOUXxe8EEnn6R4DUDQLnPiSPZvvG8xYd1gNFF2TEv1izR8Hc7sj
x0cwQVyvEKd2tQC+TR+jQ2usw4slkpxleKhAdhUEGePk/Z+uthb01gzI/fGpJBC+
UQuwjX9Uu3McTfOu7pyl2M7ObDGrmelTcSioLewWYYryM2qNAV6hTaCgmi5P6boC
FoRb5U39bkoSN77fFMbOi+/7Nr0pC1lMqdN4zWIFKF+zzZ6qUlntf33+CcF7VYYF
bD9W845SbE4QMA/O8UM7PNPAToqjXQEBpnWFMX73g8Am4xs0hXRFtbgCtwy4bqGv
qrQ4xLR5uuleZ7lZz1qKgd8YCvqNFosUZK0Eab3LLUy5hR2AFbzYfm4XY7/Kln9f
gVE6eVcy7Qr+inPZfmJTM33RpxoA0bA4BVaPxx5KmI/C7PMLMSgar7yqVO2cPpQB
sHVRrZKZM2UTUtAjD604mDa+BPUWsw7y0w32ZabvNcE1DJLy134=
=n6By
-----END PGP SIGNATURE-----

--41IcEhGcM6XGCGcU--
