Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD269C9DF
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Feb 2023 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBTL37 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Feb 2023 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjBTL3s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Feb 2023 06:29:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E71ABFD
        for <linux-pwm@vger.kernel.org>; Mon, 20 Feb 2023 03:29:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 6so392782wrb.11
        for <linux-pwm@vger.kernel.org>; Mon, 20 Feb 2023 03:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fPmk8jKosx/EXY+lXF0qABpMA9WCxd04+/16E+DiPs=;
        b=XiXBiWqj7BqDbbSCjrwh0+42FSatfS8aLCHGbzadnzDpCpNQq1XDr65bqWneh22PJV
         MfiBNgevkrh0FttjyHK3V1xK1yQJBbDJNsqJGXlOXNpcjtX/9ffRZ6Njyzj5JhzkVSnR
         aagalk6tcXvY/2LUdvCBTb73tImseeselBSJFCPhgnYrwSBtIyJ3/ovvPOXXR4q+xnOw
         tJN7LN0wCiy2kZTebiv6Gp0Cv1y1pYKsFuC8jWbNpB8PSU7L0Ew2OR6fmtX+urVzN1Ph
         DR9deGVOlWvW2G1u7MDRXUc44mbiKMjf1/A2dbEU8wQgai7SgKuynvTgaTqMM7aTBErK
         zuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fPmk8jKosx/EXY+lXF0qABpMA9WCxd04+/16E+DiPs=;
        b=BjEmpl/YZV8YtbU6QwrUFXgjmbZ/kIXWxJa18g2nWQMwM6P2ulgl762CHYwjC2UI1R
         0Tm4gnCxqgFn4P5ssO7DxdR0EfqK49rjrMJhdPO86kUAfOvhDNLgrDrpP7ut/9/0IjO5
         Ws7KB1tv08XElVLkdVD0iBJ+iscU9oL5VdGTkf2wZ2dhlE6halFD8Yb0LgA4NKZnR6Hr
         9DrJjni1zXnqMcY9P0nLNEgmWnz0ekxReuYnPh3bpV6+d6BZuZr6YTvdsg986c4xHHup
         tenSlmyi/p6BP9WYBh8cRRu8jZ2h1V15s15kYeKvjs7HDpZ3BWf1JFuFbbpw4yXlbRw8
         sfmw==
X-Gm-Message-State: AO0yUKWLfE5gCddGnKeJLe8s8OgQNM9MwicTXk/Izah8O+lzZ9014yNv
        eXrMWEMDUr2KTCGkTkZlopUz2phcNiQ=
X-Google-Smtp-Source: AK7set9NxVsjP6X2gmB7B5i/tPhdFMVmaYZzm3l2B6Y0NyObfNRP9Mm62AmVegQcrl9DlSWIakZZ3Q==
X-Received: by 2002:a5d:560f:0:b0:2c3:ff47:47ff with SMTP id l15-20020a5d560f000000b002c3ff4747ffmr2140709wrv.14.1676892584889;
        Mon, 20 Feb 2023 03:29:44 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d58c1000000b002c53f5b13f9sm1954396wrf.0.2023.02.20.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:29:44 -0800 (PST)
Date:   Mon, 20 Feb 2023 12:29:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [thierry-reding-pwm:for-next 10/13] drivers/pwm/pwm-dwc.c:314:1:
 warning: data definition has no type or storage class
Message-ID: <Y/NZpvu9F+MsefDA@orome>
References: <202302180504.FZilVS8T-lkp@intel.com>
 <f40053ad-d7e0-6a3b-878c-f7a13735a34a@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LpTloZvC8acIbMo"
Content-Disposition: inline
In-Reply-To: <f40053ad-d7e0-6a3b-878c-f7a13735a34a@sifive.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1LpTloZvC8acIbMo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 08:39:43AM +0000, Ben Dooks wrote:
> On 17/02/2023 21:53, kernel test robot wrote:
> > Hi Ben,
> >=20
> > FYI, the error/warning was bisected to this commit, please ignore it if=
 it's irrelevant.
> >=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git for-next
> > head:   7a77daf8223e772a225d6aa6202a5b1ae2392caf
> > commit: c901a57e39db555ad7950fd61e1470cdecc8e654 [10/13] pwm: dwc: allo=
w driver to be built with COMPILE_TEST
> > config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/2023=
0218/202302180504.FZilVS8T-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/thierry.redi=
ng/linux-pwm.git/commit/?id=3Dc901a57e39db555ad7950fd61e1470cdecc8e654
> >          git remote add thierry-reding-pwm https://git.kernel.org/pub/s=
cm/linux/kernel/git/thierry.reding/linux-pwm.git
> >          git fetch --no-tags thierry-reding-pwm for-next
> >          git checkout c901a57e39db555ad7950fd61e1470cdecc8e654
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash drivers/pwm/
> >=20
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202302180504.FZilVS8T-lkp=
@intel.com/
> >=20
> > All warnings (new ones prefixed by >>):
> >=20
> > > > drivers/pwm/pwm-dwc.c:314:1: warning: data definition has no type o=
r storage class
> >       314 | module_pci_driver(dwc_pwm_driver);
> >           | ^~~~~~~~~~~~~~~~~
> >     drivers/pwm/pwm-dwc.c:314:1: error: type defaults to 'int' in decla=
ration of 'module_pci_driver' [-Werror=3Dimplicit-int]
> > > > drivers/pwm/pwm-dwc.c:314:1: warning: parameter names (without type=
s) in function declaration
> >     drivers/pwm/pwm-dwc.c:304:26: warning: 'dwc_pwm_driver' defined but=
 not used [-Wunused-variable]
> >       304 | static struct pci_driver dwc_pwm_driver =3D {
> >           |                          ^~~~~~~~~~~~~~
> >     cc1: some warnings being treated as errors
> >=20
> >=20
> > vim +314 drivers/pwm/pwm-dwc.c
> >=20
> > 1ed2b3fca64516 Jarkko Nikula 2020-10-02  313
> > 1ed2b3fca64516 Jarkko Nikula 2020-10-02 @314  module_pci_driver(dwc_pwm=
_driver);
> > 1ed2b3fca64516 Jarkko Nikula 2020-10-02  315
> >=20
> > :::::: The code at line 314 was first introduced by commit
> > :::::: 1ed2b3fca64516d1b3503ef21929f3b5f4f41cc6 pwm: Add DesignWare PWM=
 Controller Driver
> >=20
> > :::::: TO: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > :::::: CC: Thierry Reding <thierry.reding@gmail.com>
> >=20
>=20
> I'm guessing that there's no PCI support on mk86 and therefore having
> compile test set with no PCI before we split the PCI and OF bits may
> have been a mistake.
>=20
> Should we fix this by adding a test for PCI here, or move it to be
> after the driver split so the PCI driver will only get built if the
> architecture has PCI?

I've dropped this patch now since it's obviously wrong (at the moment).
If this can be made to work after the split, let's do it then.

Thierry

--1LpTloZvC8acIbMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPzWaYACgkQ3SOs138+
s6FdLQ//XWbq7phJgwGKXbP9rCQOA08w3XgKBD7w8cfv4ZgL8HPwVVlZh7PMNkqF
7Qe8yAzHAA310nKP3DUlY+XYTZwPQK2F9yBYX4CHYR6mxSXdZpVPNgYW++15TDwa
GqyRVeEAUfjgdDEZ+08qpnTJMI4rPrw4Q6FaTgJziTa9kAgXkh2yNnJeTc6Y5Nmd
tUckvM++d6KdO2YL8i7BmjKlJd5aPWo6HoHwPl+Avb20wnT3jqXe1DPGEGrY6PfG
IvGq4Xllm4GW0ejWQxrSIZwFbrR2E02CmU2/db5/6E0jmP7O0PrjrZm5c9erk1dp
AKim1nNfzuaczcFz2UTRX7IS0zakRmhwbbXCFP7P3AwsMR6u5eYiXouU/Xv2hQKK
Y/9/G7WiMZ8mMlf36ZkJt4KfGfDo4a7mX09zkiKDaqvk438GRDGt/84Vh/MyYOws
azJEgQ82/hQ4FdUo/zpmTPrkLk35LlMXiW6BSTFdyFs+c//Viv2qdZHFM0Cv5Gl8
XuWveUZttJLr2nJPHgH4R7vZtzKM931vvMV1NIP4zux52ANDjLm3oiw352UKkzgK
NhSkixxsKDzypQqpEit+58vEGrV4yq/4MaTzWVONgXxDUblS9CALsmnhgr36uxU6
EqMKCYMk8lAs1M3KlU++iR+q3bYbq7AqvRW9gBqhjH8a1T7/vY0=
=qwdr
-----END PGP SIGNATURE-----

--1LpTloZvC8acIbMo--
