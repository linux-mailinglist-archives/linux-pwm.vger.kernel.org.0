Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F715565D2
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfFZJo1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 05:44:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZJo1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 05:44:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1885284wrw.13
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eZqJSyb3By1yvEkeTXSDZiKIi7taDnu42rZYf099+Bc=;
        b=RyQzcg7sfl+8qTcg1rFXK6oCi47o13DtlqwV1rD+nlNi3T50qTagj2+fzo4L5/GCZM
         OPF9DMEaIjZpFhmS4BVWwhAnZALx6EEcsQn+o4AOXGCao1eifxgfF46fqQs+wS0Cb8OA
         Z6N4p1tRAKUOWitppSxVAEgBks0qlY7+R0nMVVi8mIBfhIxZG3xAeNE3veLvjn55hfHh
         I4YIcySjzT/O+jNtcmvu1+WB4nKaxl1HFBjfoBtvmTqvkHpY7vSpr+PSIZsgGt7/X5p/
         bc+FJddA8pHFjb88QTF9rIm7riiWnVCh/GvPjRHT/nmXJlw8ZiUWbOkprn3sxuQ/lrwp
         bKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZqJSyb3By1yvEkeTXSDZiKIi7taDnu42rZYf099+Bc=;
        b=no/Ka1UsSXpqnM3Bg4IeNGxBWwoFOw2sl/D3aqF2CHuKIiSpN2eiiU8IVjqKGM/Hsi
         u40rC7jYkGelyy7x++PAW3kMlUL/gvbNEvN3AgWEyfItV75T2xNJRNvk1+FOaJMRwCVf
         RIJWyVyngcjtZ3e435JADgLQ/FNXRVImT7diRLymf6P59e80vc10/61XP3Vo1rxpvF0E
         L1c2GkLaV889wvoBly1c8iOMlqMJDY6xPI92Aazbto60mG0/v5HiplmvY8qi/G5dO4ZH
         ZPfNEDT/Qdnn8TRvErhQ0r5ASC14nTd2i2V9QeG8w/KYc2y3W0BRzesPidUgjRVD4pcJ
         Cj0g==
X-Gm-Message-State: APjAAAVYZLkkDbaHtqeJcS+YcVX/vmY24QtP/RxI0YarCIU6SbE0VZ4b
        t3AL+m7fUSqDp+qFy9mL5hM=
X-Google-Smtp-Source: APXvYqyengN0rpEZ3db9vLkhe1KzbKfnGLK2fUCTvSaEL4fiOAHVRnbyrs59an5XyzR0Re7v/UNF1w==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr2885997wrw.254.1561542264500;
        Wed, 26 Jun 2019 02:44:24 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z126sm1980003wmb.32.2019.06.26.02.44.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 02:44:23 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:44:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-pwm@vger.kernel.org
Subject: Re: [pwm:for-next 13/37] ERROR: "jz4740_timer_base"
 [drivers/pwm/pwm-jz4740.ko] undefined!
Message-ID: <20190626094422.GB22424@ulmo>
References: <201906260804.9UofywY8%lkp@intel.com>
 <1561510359.10069.3@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1561510359.10069.3@crapouillou.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 02:52:39AM +0200, Paul Cercueil wrote:
>=20
>=20
> Le mer. 26 juin 2019 =C3=A0 2:47, kbuild test robot <lkp@intel.com> a =C3=
=A9crit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git
> > for-next
> > head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
> > commit: e9bd35ff751fac8755fe3480bec1f470383f4522 [13/37] pwm: jz4740:
> > Drop dependency on MACH_INGENIC
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout e9bd35ff751fac8755fe3480bec1f470383f4522
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >  ERROR: "jz4740_timer_base" [drivers/pwm/pwm-jz4740.ko] undefined!
>=20
> Looks like this patch was a bit premature...
> I think you can drop it...

Hmm, I didn't catch this during my build tests because I hadn't updated
my build configurations to leave out the MACH_INGENIC dependency, so I
was still building that and hence getting the symbol.

I've dropped this patch for now. Let's look at that again once you're
done untangling this in arch/mips.

Thanks,
Thierry

>=20
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> > Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel
> > Corporation
>=20
>=20

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0TPnYACgkQ3SOs138+
s6Hnsg//U24yrWvZVoBHNBP1Yf+RnAW5HxL0ir9CUHqOk1wTa2sHUr6Ga9EnVvZ7
TQjUfE8m0Miv2wA9bPlSgapF9LkkEckJPjUhEZ8ObcDA2tdUl6eORIXGB6VI3uhC
s+VfwI2a95jlfJZa4TAjAcOJA6gW9TcWtmPbmZWsRYsbqFpBXD69XKQa/8T6uT24
DXjbRw+x8p2mAfUKaaAx4Yn3Sk8uyYqHTmjSUDuR0lg3HdX+iEAkLBmrbQB8LmOh
m9FkDybr1LLatdruYh+8XaHzA+BSpChpAJR71jLb5wbMBXANROseEVvwOfJfVikz
VFNDb+X3KHh9U3LQTOoyZOpRfVLdfFaV2nE6pQsuiJC+/Igc50HFLtxa3EMy1o4Q
qIOfcTYx5bMP3UwPxcINgrutpKtYIFRr9B+4qrRrGjhaQdymYBrW7ocSmv8d6KEE
EsQMtmim6apXb8Hbr77oRa9H1o2PnjcGHVtWIRwxU2AwZiXvAkuF9b5Gxy8bxHED
0r5AiRd4Lvvf9MpxpTlJECKFUNA/jLIgkCO/dwlTv8pgspt4Uq2POidk8DZu0al3
B8/IoMK5OoJvMV1gQGDo1qFN+IijWBDcJetX4/HMD0wK3OcectB6fvBHkaTdD2gc
rc0goB2AB9MNyqSPHYIJs1H/p0GdXfBJpJGshiNHKUI6L5/zKV8=
=9sTv
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
