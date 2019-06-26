Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAD55D17
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 02:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfFZAwq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 20:52:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36332 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZAwp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 20:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561510363; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/KoOFN2DD5uJ1k75F4UR5a8Vax/vDr28SFIl1LyENM=;
        b=dDnML/+uGN67RsnENveVkjfUpTPWyj5Z+CQinZIi+4PKqujBynY+df2zz/PX/ErZ6i54F6
        39Jtwxq7gBTLJvXfnbbd7Rk5cjQs9W+XfOcBrGIT55XQ5Rogi846PeW1Oz7auuHNimqo8o
        jBVKrdBJKgtXFtTTRLYRyfQq4wr6KY4=
Date:   Wed, 26 Jun 2019 02:52:39 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [pwm:for-next 13/37] ERROR: "jz4740_timer_base"
 [drivers/pwm/pwm-jz4740.ko] undefined!
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Message-Id: <1561510359.10069.3@crapouillou.net>
In-Reply-To: <201906260804.9UofywY8%lkp@intel.com>
References: <201906260804.9UofywY8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le mer. 26 juin 2019 =E0 2:47, kbuild test robot <lkp@intel.com> a=20
=E9crit :
> tree:  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.=
git=20
> for-next
> head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
> commit: e9bd35ff751fac8755fe3480bec1f470383f4522 [13/37] pwm: jz4740:=20
> Drop dependency on MACH_INGENIC
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e9bd35ff751fac8755fe3480bec1f470383f4522
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>  ERROR: "jz4740_timer_base" [drivers/pwm/pwm-jz4740.ko] undefined!

Looks like this patch was a bit premature...
I think you can drop it...

> ---
> 0-DAY kernel test infrastructure                Open Source=20
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel=20
> Corporation

=

