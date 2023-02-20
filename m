Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74B69C6E1
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Feb 2023 09:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBTIjz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Feb 2023 03:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjBTIjr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Feb 2023 03:39:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22888F742
        for <linux-pwm@vger.kernel.org>; Mon, 20 Feb 2023 00:39:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg37-20020a05600c3ca500b003e21e018039so1119214wmb.3
        for <linux-pwm@vger.kernel.org>; Mon, 20 Feb 2023 00:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1brjSwaYvIy2QT7BllKUalBrJxVESrU/f21QgCAfrQ=;
        b=L0BtpiFm1EqpsOutaRKwaPprtfqFfkhNqr1elClCvs+CRBEPbU5yUySNZEIiu5z7HW
         P9qLbDN5DidP5aWq2guZLOdtvFMV2858BAI8m0FT4t/CiQON2FidNPx754WvWTnSJRuS
         lUpupmA4zgTNzSVxaNHVIGGRxnvM5Fm4MxHKPkcowBW+JcFqjBTlvsQlEerUjyMZ/2bt
         AYjylueuknTtc1aKD/vawKrqFSgalJE9Sb7r6BpOVACJYw9fmgLKCUMZ9O/4hG122fKN
         JfcTui9ifHn2dKkeeGSjwbuQsA/i2RJByXGoipQisB2W6VM/9MTsjKPZXKn+K2W38zGl
         p6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1brjSwaYvIy2QT7BllKUalBrJxVESrU/f21QgCAfrQ=;
        b=OqSyQzYwyiNxxSkDLVA5Hi9C6YPJH6/23VDiD0BlDP/76wNjsMt8tc+/wPcPqzbUIu
         RUmPMzLrGA/8Sohl2qIxJVIaYdiqNsTyGCUtH6QEsiVzaTOCLOCH/WAuvoB5jcGOwVHY
         8w8zimY5Wgn1i7OjpMhR7Y03tPKKCgfB1yyORApPbtr0A4GBgGf45KWjSlrQdhWlidO0
         ngd6s14GqYODGikHcO72eQYgtJmRJjzWEjicV2Rd7AyCWFtg38TgTNVd+xwVD8MELb8N
         VLjaUieYL5SzZ7QWltC1whHEs9gzJit5RdoFm8AHqcjiYtBSQEnUoMoWKyI4Zx0qFKvn
         2R2Q==
X-Gm-Message-State: AO0yUKXY2IRuWV1D6SNj/SaR/w88QR0zd1sgkHemx5rwJN5NrXrML1eK
        9mPo17IchY/6dEkPVW0SqgkGmJQlo5FhpGyl
X-Google-Smtp-Source: AK7set+C/4it+aV6KClVoyft9qYKFiu/77zOsVqECtlD1WSEGTIjw+nDLJ0YBB1txeWmGv6SO74snA==
X-Received: by 2002:a05:600c:4393:b0:3df:dc29:d69 with SMTP id e19-20020a05600c439300b003dfdc290d69mr7026243wmn.36.1676882384584;
        Mon, 20 Feb 2023 00:39:44 -0800 (PST)
Received: from [10.35.4.184] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y25-20020a1c4b19000000b003dc4480df80sm9925632wma.34.2023.02.20.00.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:39:44 -0800 (PST)
Message-ID: <f40053ad-d7e0-6a3b-878c-f7a13735a34a@sifive.com>
Date:   Mon, 20 Feb 2023 08:39:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [thierry-reding-pwm:for-next 10/13] drivers/pwm/pwm-dwc.c:314:1:
 warning: data definition has no type or storage class
Content-Language: en-GB
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <202302180504.FZilVS8T-lkp@intel.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <202302180504.FZilVS8T-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/02/2023 21:53, kernel test robot wrote:
> Hi Ben,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
> head:   7a77daf8223e772a225d6aa6202a5b1ae2392caf
> commit: c901a57e39db555ad7950fd61e1470cdecc8e654 [10/13] pwm: dwc: allow driver to be built with COMPILE_TEST
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180504.FZilVS8T-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git/commit/?id=c901a57e39db555ad7950fd61e1470cdecc8e654
>          git remote add thierry-reding-pwm https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
>          git fetch --no-tags thierry-reding-pwm for-next
>          git checkout c901a57e39db555ad7950fd61e1470cdecc8e654
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/pwm/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302180504.FZilVS8T-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/pwm/pwm-dwc.c:314:1: warning: data definition has no type or storage class
>       314 | module_pci_driver(dwc_pwm_driver);
>           | ^~~~~~~~~~~~~~~~~
>     drivers/pwm/pwm-dwc.c:314:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>>> drivers/pwm/pwm-dwc.c:314:1: warning: parameter names (without types) in function declaration
>     drivers/pwm/pwm-dwc.c:304:26: warning: 'dwc_pwm_driver' defined but not used [-Wunused-variable]
>       304 | static struct pci_driver dwc_pwm_driver = {
>           |                          ^~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +314 drivers/pwm/pwm-dwc.c
> 
> 1ed2b3fca64516 Jarkko Nikula 2020-10-02  313
> 1ed2b3fca64516 Jarkko Nikula 2020-10-02 @314  module_pci_driver(dwc_pwm_driver);
> 1ed2b3fca64516 Jarkko Nikula 2020-10-02  315
> 
> :::::: The code at line 314 was first introduced by commit
> :::::: 1ed2b3fca64516d1b3503ef21929f3b5f4f41cc6 pwm: Add DesignWare PWM Controller Driver
> 
> :::::: TO: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> :::::: CC: Thierry Reding <thierry.reding@gmail.com>
> 

I'm guessing that there's no PCI support on mk86 and therefore having
compile test set with no PCI before we split the PCI and OF bits may
have been a mistake.

Should we fix this by adding a test for PCI here, or move it to be
after the driver split so the PCI driver will only get built if the
architecture has PCI?

-- 
Ben

