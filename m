Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003CCFDB70
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOKch (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 05:32:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOKcg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 05:32:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so10359166wra.10;
        Fri, 15 Nov 2019 02:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4P7LKpD8W1fNnV5/DCXDPX2i7T5T2T2R367oCbQT/qg=;
        b=Wz/9hmsus/RKdihDzD3aRsTnyG9+dr2/ikigu9IpB7T4OmAVUVLmxLOZPfwtb9fw59
         QE3zvf9tHC8opTx4QtdriKOhNSp3pMgROp8IP0AunVPDjFUvTER56O2j+wh/oCSsYuDj
         FiS7jEzljAJRYQaPCjHJFdUQqP33dUSILd4UBxuyfxsE3cp0IFskxDekwNrBa8QjBqI0
         /skKOa7z+kJeZT/m8pTeNq+pKOeuiVl1rPyp9XFljH/NUvRrHoakwAkm6DZkEyoQ43f/
         XmG0kpXGX/6Fall6DmD8eP5FGrIaNk/IbS6Wdy3iR5AGVJtLyd/vKIvhNGOu43lqrHeg
         KodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4P7LKpD8W1fNnV5/DCXDPX2i7T5T2T2R367oCbQT/qg=;
        b=IAEUW1+OO575KfsXTjxRmGpcN6Z5MrEz8ki74Qs5VN71OrllbbI4iLn/0SIqsMBUQf
         JNo5CmoYcRZi7LeZ29wdbss74dA9G17vnOe2Re04I0Zl4N7lCQdEPHCmi+aq+kVBGBfu
         as3xCr2HD3XmhY0dHyCaxW8EhoAC39zKXryQoJzniR7M+J2RaOqSCSVkDNBL6TZ3hwcc
         2mwTNKjb+6x7YuJpt827PsRV52/fPJdI0injs/N7+ZemrZTN0TrxWUkSAC9e8QULXuiX
         dnzRF9AFwKz6075qy6iToeqWFycJTxV0gdJ1RlwEEaVNrVUWA6h67Pajkx1oLzdz6JYD
         ok7g==
X-Gm-Message-State: APjAAAUZrnXAl9HeDSuK7gwBMEoJBPVWztZJNag4LxMvNDkNAy6pBjMA
        SuKEWPiN+24uRyzK4DI/G38=
X-Google-Smtp-Source: APXvYqzKUMO4uEWNIDmWe867mvQw2XuTcmfK/HCiVpPykrGkHc+c5poAnpNl3MdVoGq73OzRr7EsPg==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr14120197wru.344.1573813952143;
        Fri, 15 Nov 2019 02:32:32 -0800 (PST)
Received: from localhost ([46.91.226.206])
        by smtp.gmail.com with ESMTPSA id d18sm11173200wrm.85.2019.11.15.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 02:32:30 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:32:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20191115103224.GA944026@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
 <20191016101539.GC1303817@ulmo>
 <20191017060247.GA12487@codeaurora.org>
 <20191017104313.GA3122066@ulmo>
 <20191115092745.GA21025@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20191115092745.GA21025@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 01:27:45AM -0800, Guru Das Srinagesh wrote:
> Hi Thierry,
>=20
> On Thu, Oct 17, 2019 at 12:43:13PM +0200, Thierry Reding wrote:
> > On Wed, Oct 16, 2019 at 11:02:47PM -0700, Guru Das Srinagesh wrote:
> > > On Wed, Oct 16, 2019 at 12:15:39PM +0200, Thierry Reding wrote:
> > > > On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> > > > > Because period and duty cycle are defined as ints with units of
> > > > > nanoseconds, the maximum time duration that can be set is limited=
 to
> > > > > ~2.147 seconds. Change their definitions to u64 so that higher du=
rations
> > > > > may be set.
> > > > >=20
> > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > ---
> > > > >  drivers/pwm/core.c  |  4 ++--
> > > > >  drivers/pwm/sysfs.c | 10 +++++-----
> > > > >  include/linux/pwm.h | 16 ++++++++--------
> > > > >  3 files changed, 15 insertions(+), 15 deletions(-)
> > > >=20
> > > > Actually, we can't do that without further preparatory work. The re=
ason
> > > > is that consumers use the period and duty_cycle members in computat=
ions
> > > > of their own, which lead to errors such as this:
> > > >=20
> > > > 	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.=
o: in function `pwm_backlight_probe':
> > > > 	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> > > >=20
> > > > So I think we need to audit all consumers carefully and make sure t=
hat
> > > > they use do_div() where necessary to avoid such errors.
> > > >=20
> > > > Thierry
> > >=20
> > > Hi Thierry,
> > >=20
> > > I would like to try doing the preparatory work by fixing the errors s=
een
> > > in consumers so that this u64 patch may be applied without issues.
> > >=20
> > > Before sending the patch, I tried "make"-ing for arm, arm64 and i386
> > > architectures to check for compilation/linking errors and encountered
> > > none. I see that the above error arises from using a cross-compiler f=
or
> > > arm v7, which I haven't tried yet.
> > >=20
> > > Could you please provide details of the compile tests that you run at
> > > your end? I could then try to reproduce the errors you see in the
> > > consumer drivers and fix them. Please do share any other ideas or
> > > suggestions you may have in this regard.
> >=20
> > I keep a set of scripts in the pwm/ subdirectory of the following
> > repository:
> >=20
> > 	https://github.com/thierryreding/scripts
> >=20
> > Typically what I do is run:
> >=20
> > 	$ /path/to/scripts.git/pwm/build --jobs 13 --color
> >=20
> > That requires a bit of setup for the cross-compilers. I have the
> > following in my ~/.cross-compile file:
> >=20
> > 	path: $HOME/pbs-stage1/bin:$HOME/toolchain/avr32/bin:$HOME/toolchain/u=
nicore32/bin
> > 	arm: armv7l-unknown-linux-gnueabihf-
> > 	arm64: aarch64-unknown-linux-gnu-
> > 	avr32: avr32-
> > 	blackfin: bfin-unknown-elf-
> > 	mips: mips-linux-gnu-
> > 	unicore32: unicore32-linux-
> > 	riscv: riscv64-linux-gnu-
> > 	x86:
> > 	x86_64:
> >=20
> > The blackfin and unicore32 builds are expected to fail because the
> > blackfin architecture was removed and there's no recent enough kernel
> > publicly available for unicore32.
> >=20
> > The last two entries in .cross-compile indicate that builds are native,
> > so regular gcc from the build system will be used.
> >=20
> > Most of these compilers I've built from scratch using pbs-stage1:
> >=20
> > 	https://github.com/thierryreding/pbs-stage1
> >=20
> > Note that I don't guarantee that that build system works for anyone but
> > myself, but I'd be happy to hear feedback if you decide to use it. That
> > said, you can probably find prebuilt toolchains for all of the above in
> > a number of locations, like:
> >=20
> > 	https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >=20
> > or:
> >=20
> > 	https://toolchains.bootlin.com/
> >=20
> > Thierry
>=20
> I tried replicating your compilation setup and found that it worked
> right out of the box with no serious issues. I decided to build the
> compilers from scratch and only had to update my make to the latest
> version and also install help2man and u-boot-tools on my Ubuntu machine.
>=20
> I found your setup very easy to use on the whole and very well designed.
> I added a "set -x" to the /path/to/scripts.git/build/pwm script in order
> to figure out how it worked initially.=20
>=20
> I didn't add the lines for unicore32 and blackfin in my ~/.cross-compile
> file as you had indicated that they were expected to fail. It was very
> convenient for me to run the build command for a specific arch by
> appending its name to the end of the command you provided and thus
> verify that the compilation errors I was getting were getting fixed for
> that arch. Then by simply dropping the architecture's name from the end
> I could run the build command for all archs - very cool.

Great that it's working for you!

> That said, I wasn't able to compile-test avr32 and x86_64. I couldn't
> find avr32 in the targets folder of the pbs-stage1 git repo and so
> couldn't build it from scratch, and I couldn't find a pre-built version
> either.

I use a version that I once downloaded from the Atmel website, though
that was 4 years ago and it doesn't look like they're distributing that
file anymore. I never managed to build a custom version of the cross-
compiler for that because support was never merged into mainline of the
GNU tools.

In any case, we don't really have to worry about that very much because
AVR32 support was dropped in Linux v4.12.

> There isn't a config for x86_64 in
> /path/to/scripts.git/pwm/configs and so the build/pwm script wasn't
> picking it up even though I had added a blank line for it in
> ~/.cross-compile. Those are the only two issues I encountered with
> replicating your setup.

I could probably add a 64-bit x86 configuration to make sure we've got
that covered as well.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3OfrUACgkQ3SOs138+
s6EF5w/6Aok2TXRHpBoqNwTuPLdailH7SSBMYylRlN3dpI/wjVmyjrwtaK1L73Du
MD8g6iQM+1xhIXVDGzvMLE1abGGFgksopQrKc3gu+F5iNki2HlO0zonZhn5J47M6
2SKevWUSGJ2FZDeMIZ41l6PmL0OMdS9ckdTbn1askkymYCun+rUzySzMy3uulDTl
kGq7jdpfVNHFOKk3gVKU2u2uH0wbBkbfDWy2759K08szYE33WfuDKVw9Y4RWKt19
qaV06K3NdmXXSGFKz/Q3VtcLqqPNBp8Nnx88rNq4NNvi3xYoOaJqpQk1At4HXOuq
1mhMXFt/VLUKHdz3I1YfHBQMZV4alIyHZaMxq/JvvdbDKHpX7K1ieWrIqdsv/xZf
Px4wcengLXDCJ471hhEXA70WdUNm3oDroYIbTuVYAioVLmHVO3Y2QEwFWWRbFa7i
J51sIuo9kISgJsEwFr3m1pk73xMORhRbSZ4FgbZStr8ochgf2hN04xmDMfExp4/o
2WT4kxO3lWbK+kzxyVhRpPEV1otDwuuAz96PyFwgO10U1v0Rhc8Y7G26Vupjgf28
thzoTc/ipSh6L5G9929Ajsi0ZIzOA/Fdxmc/JxXPV59Jqz/ftKLwttYhqZxlzd/J
2TuJAzWOd39sQNw/0eF0zUtuT4EIUdqVIWZs5R2jvR6LuGmpgCQ=
=47Ym
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
