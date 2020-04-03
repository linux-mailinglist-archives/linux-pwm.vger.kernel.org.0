Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE519DEA2
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgDCTng (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 15:43:36 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35729 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTng (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:43:36 -0400
Received: by mail-wm1-f50.google.com with SMTP id i19so9021492wmb.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2020 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5ImpcTwqakFfE/7PPdklfuWQUdS2NOjWVCZLSkiWYQ=;
        b=Cpgwisebq0ciPNLcXZ6gC7q08aP2MRUOaEyxhu6TEsAWJ+KQywo+6oxN4YZZV2JuvN
         AgpK2R9z/R1TYrnz2oQ6JOzzz/Dmd3oFDrIxRVen0LOa5bCmqcCxUE0qCNUDeUGJGmlv
         nVptrR+fddYDyMqQ6KfRuMuC3v8Yd0WvR9HhvmXyD//0Olz+82xorpFehou1AihW7PFO
         YXkHhoA7M4Cx+GWfOdmoVNYD33IoAXO1lUGAB3kVPl9pnFC7gSNLH7VFkrgKkIKlUuwF
         TtExSGqxxbdydn0QiYVg5TfNC2QjP6wl7KD4vTqAqrZyIjIgwNFTCJzPVZO7cRlar+Th
         punw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5ImpcTwqakFfE/7PPdklfuWQUdS2NOjWVCZLSkiWYQ=;
        b=Ts63jzlvVl4Y/SWB+THq+wIsI7i6X7MivCiarMrQr1wse7vk0iomgvtDWSAjHXmMeS
         BhNsxpRpQWe9lQNXHWjwtZMy0q5krZFh732bVZ4hlaEucN4560x5bYpDyn9kJbA/osof
         TysivdEz2i+KvsOoHPToX0/cwHrCMhCoATGQkFDdw07uWovzP9X0RlEwm8DxPrbiXnuu
         M1kbdSTur/gcPNMnezStd8vTG7UoKJs+XIPQ3mmKH91f92x1jOuc7a8Khqmc/YGndJBc
         2e7ny9u6Ul/2OpoKT0UL8MpQoMnkumyHXbI51ZW9pxcMDVH2Dd2VnrGOar+SzElYLbqL
         z9Tg==
X-Gm-Message-State: AGi0PubTaO4/AXJM5iRmB1zagK/fEx3uPEH1mcSwLdVqhB9CNjxLT4VQ
        xMLnqT3UYklxbvBIV4BOebo=
X-Google-Smtp-Source: APiQypK4zd6DIX5ClJOPkUzmViespBHwUitg+1ZDe27MSVA++Q+nUNmML/c2d9NrchQfFxvCzuNP+Q==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr7469548wmi.61.1585943013445;
        Fri, 03 Apr 2020 12:43:33 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id a2sm4044998wra.71.2020.04.03.12.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:43:32 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:43:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH -next] pwm: make pwm_apply_state_debug static
Message-ID: <20200403194331.GA201060@ulmo>
References: <20200402065718.32433-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200402065718.32433-1-yanaijie@huawei.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 02:57:18PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
>=20
> drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
> not declared. Should it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/pwm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HkeAACgkQ3SOs138+
s6HyVBAAtZfqkAbBTNmDItMz7Hg9MfpiGTj9ySzWgkyJXEG97AdvuIxvsvv64MyL
nu/bTHnvCti5d024RGET7ymfgkmrBF/jt4WDWUE0tSsFNc2Bh9LtLZDB8L5Mqqtd
YufpMDVhr4VRDLDtS8/APGiK7Wwlhlx6OKphC2JSMWOxXaZOxZ95oqHxgt6S4Y4K
z4PxEI86eDmg9BGEdQLCI7adxASKMpbobkRIe9GrIMq8tl00LICRgm4F5nauXOSA
scFl25EmcTrbCPEmOrjQpHrXZsw26aUKgK7Ch6uwAfMA44aCtccKx1SOEcex8IrX
NfF0c0wg1kwQ1JZ0sgPgIWcO8lhiyntzOzORgcofNAeV5gk4EiN4ViuLyARYcVKD
mrs9OkOwQJJL876tug6BR7Cc5KHFNJYW5+XD37pdPgnXDDa2ixwbkzme/7m8a+9b
WdUkzRoyjDvTZAa/XHaLDF2PAOn8gfLhPTmWkahPDesFNugpd+DIeqW3MeY3bt06
6iMsxjKGaEl+NsUS8JYDLE4o787tnQoF4ky1Qmvj/LbE0ZJdYrTYvDGBk8mqIEPi
rgQjCTIkPBnRkoyCKEDLoj1I7FZpb2mMkfDpN9lQ61pVsQXQzO0Ve4JxkPmKg9r9
FOSVGtXLJ1aCRYcjvPWjO7w4ETSvDJ87hqMol7Mzq2G3AzM9EaQ=
=ZJEc
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
