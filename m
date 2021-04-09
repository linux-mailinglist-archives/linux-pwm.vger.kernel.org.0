Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31410359E9E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIM1O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIM1O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:27:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CBDC061760;
        Fri,  9 Apr 2021 05:27:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so6313891edu.10;
        Fri, 09 Apr 2021 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+NoIuLmraW7WrDEIWjYM9bekRcvNvAvsNvzQ1CZ92l4=;
        b=ucH6bHS+8d0oGOyOMjbzJVnM9UgTV5uR6XE0aARQIzTZxOkdVmA/eC6Klo/2BPvJyn
         nEyi82Z+y+0HU5r2HhJEj83PfoceOWXSKzFNHVDrXfB8+wUq4kJCAZTHALij/JUB1yxV
         5Yc+TssTeFY8O/nXnDaYOxx2PaiVWiE+dF//50j6guuzcp1hI4OeamBiHdBdYVhh/Msb
         FpFJrTVmHr2N6867pd+Z5ONw9Ph8V+dFLJeHqamb4hcUm+SadOkRAV8qGXgtI49gVyhP
         OLu6uZAnGvHAuQJVubXpmGsFpywcqYKz8QWyTGnJb+RpkW+4M1XByumO1dzoUgPYqCaE
         nSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+NoIuLmraW7WrDEIWjYM9bekRcvNvAvsNvzQ1CZ92l4=;
        b=aY4B6aVfO9ZjX35TE4hCJYGdnGS7S2xGz4aDyUHRIVPZGRky7CjR4lC0KraQu38iY7
         LyTamzKywTLZr9iTKddDcWjwScb8OxHltdK/nFcTffp9jhuamYjbnHjQksEDr2v4LGra
         Rm4z5fATo9aRkGkWptu4ss8hq8IKxgs4I+0UutUR7HbCZQnYGtzyWDl7JeL0q0vH2Je2
         osmAtrF/xl2zrJ0Arlfarfx0F5sazS+gm3QnWt9YC8vTGT58DIIsszLC9jw1xF6ETqds
         E9O6RBP56S9qGYtOGa/Q06UvUM8trU+t8d1dxnDIrKXlpcE2PeAzauM5Q/kQpSTWp6lH
         wQ0A==
X-Gm-Message-State: AOAM533TTfeweUnQ+z6CJJZzPscpd2zx2X00+wqy4as9EM59on2V/3vX
        qm+iPiA6v6FzciA1IgklApI=
X-Google-Smtp-Source: ABdhPJyxjfvzdOcSd857ibe5u5kjyCcl896iR5wPhcUb2EniGednDQT1JC0Ox0HrXjM0vCNgUuZM4g==
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr17221009edb.62.1617971220527;
        Fri, 09 Apr 2021 05:27:00 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id b13sm1350588edw.45.2021.04.09.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:26:59 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:27:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 4/8] dt-bindings: pwm: Support new
 PWM_STAGGERING_ALLOWED flag
Message-ID: <YHBINhLa3pCZjoxO@orome.fritz.box>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-4-clemens.gruber@pqgruber.com>
 <20210407053357.ok62rqpgyqou53m3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bALA5fzjI4YAv2cb"
Content-Disposition: inline
In-Reply-To: <20210407053357.ok62rqpgyqou53m3@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bALA5fzjI4YAv2cb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 07:33:57AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Apr 06, 2021 at 06:41:36PM +0200, Clemens Gruber wrote:
> > Add the flag and corresponding documentation for the new PWM staggering
> > mode feature.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
>=20
> For the record, I don't like this and still prefer to make this
> staggering explicit for the consumer by expanding struct pwm_state with
> an .offset member to shift the active phase in the period.

How are consumers supposed to know which offset to choose? And worse:
how should consumers even know that the driver supports phase shifts?

Thierry

--bALA5fzjI4YAv2cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSDYACgkQ3SOs138+
s6HaHBAAqqXtYcIg6E5ADZv6/LDzrzvykS0Z6SBNDrh6QKpwkfHyhejv06aRtDm9
NZ49Flpuj5+hxTH15SKV9A0NRjpIs6e9L/8mq5pS6HhusKyKZelVUuTKEtH/aDI1
b53zcan3ooRkNfmKwJQnWvfoUIG/pXUXrXMYCkf2TYnQxafBLr6EeSqk3YGoU/GN
uLrYY6HOVe9zmz4pFfHSSAX8hHYW4FUsuqTeO2AOOH3eygICzNFhT/T0Wd9f6txY
QXWU9Wjw3GjEAxf/ispALrQuYacnjXtfKaQdN32RM0W1Z2sYf78A3tjqa9vaYXX1
RJasmE9z1gVLwN5eIk53xRBvMdUvtuEHwBHZK8mKtrSZ8zJ2GkGKLdZPtvHzcFPN
c4QmTZzKYhZ6VN91pWXI7wpKmC1lWF1uW7JVepYl5iw90U9E3bOhJPzQi77+ZGux
SJacNNwzRTfLx6KERgTGB1adIhEAxbUA3yiSN8ktVNrlx8ZN5EuLEhlU42Z2VoHc
5GGfCysKDah+mnnQElekv57+z2E2lyJZhqwbvliXlV0jYQmoddP1f7yt7vzBeymD
E1Tu2hFl/fz7ypF2+rxgm4aoMYm6a4y6Zli2FelvCE0J/UXY/FS3fxnHMLL3W8Po
buGPvntKEz7S5SrpHq1Pw2p5C16JRcgQYC1tAj162RjSVnhgFOY=
=ia/o
-----END PGP SIGNATURE-----

--bALA5fzjI4YAv2cb--
