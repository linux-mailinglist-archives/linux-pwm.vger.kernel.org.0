Return-Path: <linux-pwm+bounces-3364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F862986230
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC8A1F2750D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624101171C;
	Wed, 25 Sep 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WKxJbdT4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58711B963
	for <linux-pwm@vger.kernel.org>; Wed, 25 Sep 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276466; cv=none; b=avBqT4T2n9JqYqRXuu0ETxwnoQcYUpgJmZW/y/C3CuXHUCI+FF8CudfeNU+97rreMFz6C305NdZy97IOkv0Q36juACR67FLvAVUtc6i+0TdrbHqF1xR2oYu6IkAIStYxKyTpJkDTrvo7gjAjVHx3aYJBtRQ31tZqNsFEAAXXaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276466; c=relaxed/simple;
	bh=1jc+pSWqIGg4sdAMIp0BE6UyNagjlvMpmDe2YucAOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkldEMoZY5mTP6sxB8D7Pza3ALj3NFWLe0pwr4Mkhxso5NiDSk52UJaAbIR4q+RMm27h7YqJOuLr3v7gQBnVkRKBirb4nLTKmGgE5RQHwJL2eeK6IbSQDH+dLDdE+Pnu84FMqyfqOsdIvVi3mSepF4DhkRzEUjl/HXJBJ6LT1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WKxJbdT4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so500500f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 25 Sep 2024 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727276462; x=1727881262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFwaEjEcGbmOpy8y/A32031iEzvAr4b+8vGYpFCTIAQ=;
        b=WKxJbdT4Q7CxaL2Gq8ilL5Am5n7xVDtSQzAzf4UPfWZmwDQqL9croaVnFr9dgD8XMe
         rlVeOZlYk+OB8aKPDPqytz9jaztj/S8rqJ5+Z5K0Qzf91ayr1Rm0DuKBEMsjEDqY3r6i
         UpoXKTZBIwmhZuUVAmgHcLLl3uF12woUVkAV45GmTkVGWS1NxAeHPCbmNUu7PDw0vFf+
         cQQNeDWbV9+FS9cHV8754dhvRc4NUOgDljFssom2gAFYChlmTy/Np/tjJodqqljM1zvB
         n6VvpE1Q49hxaeH/0ak7iqZ4iqltREq0XObNy7D8P4njI45K86Q9oSQm6Jb2Q17m8OzZ
         ZSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276462; x=1727881262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFwaEjEcGbmOpy8y/A32031iEzvAr4b+8vGYpFCTIAQ=;
        b=NueeMJKUOjFsgFBxZVGW3nTWyfhvhR0KWrhQ+CEAKpBRp14bl74eDeC3/lygrCD71q
         2gCUe/QgPvZIVmlzbIdbODTPpMl9F/3fHuNQ/6neCwv6QpyObNOPL1lFO/Q/TfMq66mN
         4BwHmVWCvJ8hF/XsWMksaXs2ML97ZaZJPg7imDL1xkuygZXZL2p+LWnUE3DDWIqNMQ6f
         SdARmZORkycJQn9wwIDZ1XXoEC/ziMc11153W6x6QEYW5N/CvT20iO8Jr1mri47LP6/x
         ufNfzWK1G5crEnvQEcLWgdrXJfqDJwFN2mbsVuRoEruibTDi0ZJ5QsWepjiDCUlX3JHo
         UB1g==
X-Forwarded-Encrypted: i=1; AJvYcCUnOMSvSXEc9GrHtkKb8g+pFacvghbg0+i1tzwGGM+9vbYA2UjnW5xEjN5LIgRafWVvdwB04k1M+K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZmBzbPAzcuF9zHuzNv+EK9tGN2hg6u+UOavJjX7urLqyEEqc
	wffXf51PHrBuyh2EwtBS95/O2PycDm28gagMGiIY1qMZOlqin/akL5Jq5a2bv3w=
X-Google-Smtp-Source: AGHT+IHD8vU/W6x0vrnctzoX3ajNrBx9dJukfD8SQWCnX830UdEgKBVYfapZ8BfJfjKWlfB6ECZW5A==
X-Received: by 2002:adf:8b92:0:b0:374:c0f5:79f4 with SMTP id ffacd0b85a97d-37cc245ba71mr1926279f8f.7.1727276461732;
        Wed, 25 Sep 2024 08:01:01 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9811sm4220353f8f.86.2024.09.25.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:01:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:00:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kernel test robot <lkp@intel.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
Message-ID: <eodnwb352qkwukz4sgh3frk3e4porpzoz3wj3wqrp4t5wbxtqs@hkyjvxhdm4aq>
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
 <202409252009.ZbXikiQJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktev3ljfllbas3ib"
Content-Disposition: inline
In-Reply-To: <202409252009.ZbXikiQJ-lkp@intel.com>


--ktev3ljfllbas3ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 08:41:27PM +0800, kernel test robot wrote:
> /202409252009.ZbXikiQJ-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409252009.ZbXikiQJ-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:548:31: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      548 |         val =3D __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      561 |         val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from m=
acro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>      102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>          |                                                      ^
>    In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:574:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      574 |         val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from m=
acro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>      115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>          |                                                      ^
>    In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:585:33: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      585 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:595:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
>    include/asm-generic/io.h:605:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
>    include/asm-generic/io.h:693:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      693 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:701:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      701 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:709:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      709 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:718:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      718 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:727:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      727 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:736:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      736 |         writesl(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    In file included from drivers/pwm/pwm-axi-pwmgen.c:26:
>    In file included from include/linux/module.h:19:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/s390/include/asm/elf.h:181:
>    In file included from arch/s390/include/asm/mmu_context.h:11:
>    In file included from arch/s390/include/asm/pgalloc.h:18:
>    In file included from include/linux/mm.h:2213:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pwm/pwm-axi-pwmgen.c:58:9: error: returning 'void *' from a fu=
nction with incompatible result type 'struct axi_pwmgen_ddata'
>       58 |         return pwmchip_get_drvdata(chip);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pwm/pwm-axi-pwmgen.c:64:27: error: initializing 'struct axi_pw=
mgen_ddata *' with an expression of incompatible type 'struct axi_pwmgen_dd=
ata'
>       64 |         struct axi_pwmgen_ddata *ddata =3D axi_pwmgen_ddata_fr=
om_chip(chip);
>          |                                  ^       ~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>    drivers/pwm/pwm-axi-pwmgen.c:108:27: error: initializing 'struct axi_p=
wmgen_ddata *' with an expression of incompatible type 'struct axi_pwmgen_d=
data'
>      108 |         struct axi_pwmgen_ddata *ddata =3D axi_pwmgen_ddata_fr=
om_chip(chip);
>          |                                  ^       ~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>    16 warnings and 3 errors generated.
>=20
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
>    Depends on [n]: MAILBOX [=3Dy] && (ARCH_OMAP2PLUS || ARCH_K3)
>    Selected by [m]:
>    - TI_K3_M4_REMOTEPROC [=3Dm] && REMOTEPROC [=3Dy] && (ARCH_K3 || COMPI=
LE_TEST [=3Dy])
>=20
>=20
> vim +58 drivers/pwm/pwm-axi-pwmgen.c
>=20
>     55=09
>     56	static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct p=
wm_chip *chip)

There is a * missing as the function returns a pointer to struct
axi_pwmgen_ddata and not the actual struct. I remember having fixed that
after a compile test, but it seems I sent out the change before I
squashed that in the commit :-\

Best regards
Uwe

--ktev3ljfllbas3ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb0JZ4ACgkQj4D7WH0S
/k4zHQgAld2KQZJoIhEG+Pa15lWXnqRx71awdY67dtiBuM8JA8y3KJWskxR7hw2N
CCJXvmFCoqtawUoS9LxA3agkw5nF/cTU3NA+Iev27k0/msuPpi34fGULu6kkjQuh
vLT8wjkqVN66evmG0aF7NuvPf1Ulias6L+SUbBlTNFN2Vczhtk5sx0oQRBrKYBIi
ZPnWC2Qrk2TTBciSs3LyoBUxrGCbAIsAhOD1yVmDuqOFnbsUyorqIRHFurpqEgx5
wKeccBlMmkXrFtPenKvWxG5JeOU7dtcuXL6JWd9jRJKs8F4xPgBv3sNZFDmqSxIm
Ap8BpEwUTLPgs1HXHAdwvktw3BrNew==
=zrim
-----END PGP SIGNATURE-----

--ktev3ljfllbas3ib--

