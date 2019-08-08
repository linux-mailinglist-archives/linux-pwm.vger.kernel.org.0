Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5787860C1
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfHHLV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 07:21:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35683 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfHHLV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 07:21:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so90328016edd.2;
        Thu, 08 Aug 2019 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4YKtPpUsSjKKa6j0xtM+v9TmwgUzYBL0vJkaA/f6pA=;
        b=ojnZhTgd3cR6efSm/F2qR28peihKdSBRDQYi5gvz28tx1UVZ0CuoJCEA9A1+oZqFxx
         FVVNnhwEIxPY3gC9y2s5ZuRKqTedkoTsRipmzYeCqV5BKoYjwjKmdXuxGE2x25XIeszX
         Dv6BBVQqp4DXHsn9oQJcS1vVmd+qOHRWKycr7d6R6GJ51u/9AavIU7B2Q+BrV8l08oWs
         jXBArG2t1l2CyarRm3lxaF4u4wgGlP2LJp9AprNsXDcOiKirhLy7gTX2l990Q+PwzC6b
         zk0MAD38LSWj928je4KdtPyqwiHzGaiRPo3tZfc9QMGoInT2HsykdWWnA2E2HUrkzCnX
         T5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4YKtPpUsSjKKa6j0xtM+v9TmwgUzYBL0vJkaA/f6pA=;
        b=tj38oHhQfclMxaWdMzbshW8+rKGeDf0i9hiuGx7vOH7v5EJNFAhouG0DwYVo7jGVBk
         55cAcXHo3fEMS9/vjo4rt2oYgom2kdfbPKiP2pBRsSpzLiGVtAcC8u7hAqCwbb8lX+8U
         HPddoBSmHF1OlScTwJwx7rgLSqIgtr2UW9D91F1WItSoCcwit/4ig/cy4Z+R2Z9HrYBi
         R5mB6/pUe6/wxnhxRkM29IdA5kcEtcYowCR7knVYfnqBBLXYcbhls1+ShILByNdgv4Ww
         WNj3j5JhwcpzYtmEzh4C9hGQdllZCjOyhtd5SE+PP+/mrVk1CEwVlIMmfv37UzRvbtwD
         xQsg==
X-Gm-Message-State: APjAAAWb2TIFQUUXgPLuOR8sF1PQlCeYATg11kQwFzO5qV3I+wsZlqv9
        ZHHDuYL/8pFXZ5L5TJOPKPY=
X-Google-Smtp-Source: APXvYqy2+URWEusBQnuwFde0j2lBtX0JAWw9Zi9EcNe7Cp5l/4AegoEnwg8SrC483wteG/fa4ppzLA==
X-Received: by 2002:a50:a53a:: with SMTP id y55mr15412834edb.147.1565263284795;
        Thu, 08 Aug 2019 04:21:24 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id kt15sm319105ejb.27.2019.08.08.04.21.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 04:21:23 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:21:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
Message-ID: <20190808112122.GB24700@ulmo>
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 12:19:53PM +0200, Hans de Goede wrote:
> Thierry,
>=20
> Ping? This fixes a somewhat serious regression in 5.3, can we please get
> this queued up for merging into 5.3 ?

I've pushed this out. Let's give it a day in linux-next and then I'll
send out a PR for v5.3-rc4.

Thierry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1MBa4ACgkQ3SOs138+
s6FKxBAAlP3tvnhfhLVbpQqyDaN+C0XgMSOEzrHXwt4unMwechd56DQ/1Nnc+6sy
+leBJTsFDLMrecIJFsyMlwuCp4P99NvfkXynpdrC/mJPYmNPVGpvx6erYntcGUpP
9RpzEvXyKxKW5AUjcXUudAunWEODeHrJNkfFmDX1SR/ejPJKd4PWxzawY9f0xKRd
PZa8veM6bdZyHlNCKOh+FspcA0PuuQqjoxN4KkHX+siqxH36D4RYCUSBH5dAXDY5
rt8vcvW0GyL9dBrHBfWJ6x1Fbx7iYpCDn3ImvyJUEnWzw8muolKXkCwHgBE0uC54
ba110twT90SV1CZ5DwiCQOV+xEk6vAXQuwvw0jzd1d43ls7s8z2rdcb9w50spc/m
omz7foMxk1RnuiUbnq6aRQ6FbG4iRIFLEtBKzNkCo2QPn7KjNYsJKpHlCJLTjRQc
XdYN5Pfw1eOo3JCAn54V5B1IgQm4ECQlrVpj3S9akqOWivsUTcJbF9XgjRbN4px7
dMtN19V/1NCIhB4fq+9ac3oNQpBz0MsuXbiWEN3ulu1TR9vi3XglvGLRecbmKfaK
15Mb7qTvyy4DDEkFl89zIT4KFbY8jNYpX/HNGOgl+F3YOseqUbQ7BQhLtJ3FFRRz
VHz2iSj+QQ2fX2cct6pm+Yo0BpLhoW6ZerFd2mmtrxFDcQryJkk=
=JqP9
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
