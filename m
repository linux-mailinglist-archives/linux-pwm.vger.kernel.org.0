Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1228535FA65
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhDNSMB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhDNSL6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 14:11:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D41C061574
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 11:11:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so32776977ejz.11
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJ80ky/xAeMUbqqtNjkNOpRw63h5DMH7hNR73rKPRgk=;
        b=CReSQ546pK3br36paSJmPHY80z4Ba0IlfXpTxbVZ/R8HpgyThdW07QpnDLRLba1lmi
         Y1JiAD53Pksm33Ya9wL0pXZ//vw/zC/se3gwQ5u9qRL61PfoaBUU/mQLbGNbBkB7hxSw
         iv4V/3pNXDsdVSI5sCp7OAN3Ta2cOfVjCO8/4R9NhLHr0UlPNh6mlkmRe39smKnFXZa2
         hl/VWn6oUixfA0I0CDC56wsqf2N/lchNNMfgWYcB2gyaS1ZtdgZ9IRFp8PKui18o8rFU
         wp00hshqQgT5v0O226RRbPkWlEfsNkU52OFNeId2yc2iWcn/XTK0eM9QG58SRNJDtVPV
         pJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJ80ky/xAeMUbqqtNjkNOpRw63h5DMH7hNR73rKPRgk=;
        b=mniKzNw0bLefSeyFLN92+C4x1/1NBh7vdYy3ZVPTElAlhFTnO0OuU9Hq05C1g8naqS
         /g3m5H2XZLR0fCWhWD6Shw74/acX5+nFiRD7L1pd5HozMg99sg0ydYMUV1dL4gxCJnUg
         jt+EcldC6qbLoo9vaTG+ATAVi+bJr+kGo1OkDnX+e36dvcE8ICEa0vOFA81eKmuSoS3m
         0toEAUhFdVKHXPcDYp84lu/4JKYGXRPVbxYmd4ZrtHzUC+H+1qLe9TV1gPKCtFGli9o5
         cA16RD1Je5Cfuu6PY1sWxo7xL8iM+G6pDfg79+hRS5WbAr74y/++5rPS0RGYWz24MzxY
         84CQ==
X-Gm-Message-State: AOAM532fORxLhxJEwlExgnFm6lQZrNt5jcxlGieAAG+N2+mgz/2cBL0e
        VokyeDbFbbQcpMcvAWBLaTxGaQ==
X-Google-Smtp-Source: ABdhPJzcMCCZbKDq1YH1AKKf4Uwep4ri+Gb0BmKrlZP1d0dbTKq2zfJ2dEqvVJSoCV4Fidgc1IvgFQ==
X-Received: by 2002:a17:906:7942:: with SMTP id l2mr161498ejo.314.1618423894290;
        Wed, 14 Apr 2021 11:11:34 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, ac100@lists.launchpad.net,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Allen Pais <apais@linux.microsoft.com>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andres Klode <jak@jak-linux.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        Comedi <comedi@comedi.org>, "David A. Schleef" <ds@schleef.org>,
        dri-devel@lists.freedesktop.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herman.Bruyninckx@mech.kuleuven.ac.be,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Ilya Petrov <ilya.muromec@gmail.com>,
        Jacob Feder <jacobsfeder@gmail.com>,
        Jerry chuang <wlanfae@realtek.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "J.P. Mellor" <jpmellor@rose-hulman.edu>,
        karthik alapati <mail@karthek.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <ac100@lists.lauchpad.net>,
        Klaas.Gadeyne@mech.kuleuven.ac.be,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, Marc Dietrich <marvin24@gmx.de>,
        Marco Cesati <marcocesati@gmail.com>,
        Martijn Coenen <maco@android.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Michael Straube <straube.linux@gmail.com>,
        Mori Hess <fmhess@users.sourceforge.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre-Hugues Husson <phhusson@free.fr>,
        Robert Love <rlove@google.com>,
        Romain Perier <romain.perier@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        "Spencer E. Olson" <olsonse@umich.edu>, Stanley@BB.SD3,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@android.com>,
        Truxton Fulton <trux@truxton.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wim.Meeussen@mech.kuleuven.ac.be,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Subject: [PATCH 00/57] Rid W=1 warnings from Staging
Date:   Wed, 14 Apr 2021 19:10:32 +0100
Message-Id: <20210414181129.1628598-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (57):
  staging: r8192U_core: Remove two unused variables 'ret' and
    'reset_status'
  staging: android: ashmem: Supply description for 'new_range'
  staging: comedi_8254: Fix descriptions for 'i8254' and 'iobase'
  staging: r8192U_core: Do not use kernel-doc formatting for !kernel-doc
    headers
  staging: r819xU_phy: Remove some local variables from the stack
  staging: r819xU_cmdpkt: Remove functionless method
    'cmpk_handle_query_config_rx'
  staging: wlan-ng: cfg80211: Move large struct onto the heap
  staging: rtw_ioctl_set: Move 'channel_table' to the only place it's
    used
  staging: rtl8188eu: core: rtw_ieee80211: Fix incorrectly documented
    function
  staging: rtl8723bs: core: rtw_mlme: Remove a bunch of unused variables
  staging: rtl8723bs: core: rtw_mlme_ext: Deal with a bunch of unused
    variables
  staging: rtl8712: rtl871x_mp_ioctl: Remove a bunch of unused tables
  staging: rtl8723bs: core: rtw_recv: Mark debug variable as
    __maybe_unused
  staging: rtl8188eu: core: rtw_security: Fix some formatting and
    misdocumentation
  staging: rtl8723bs: core: rtw_security: Demote non-conformant
    kernel-doc header
  staging: rtl8723bs: core: rtw_sta_mgt: Remove unused variable 'psta'
  staging: rtl8723bs: core: rtw_sta_mgt: Return error value directly
  staging: octeon: ethernet-tx: Fix formatting issue in function header
  staging: rtl8723bs: core: rtw_wlan_util: Remove unused variable
    'start_seq'
  staging: rtl8712: rtl871x_mp_ioctl: Move a large data struct onto the
    heap
  staging: iio: frequency: ad9834: Provide missing description for
    'devid'
  staging: nvec: Fix a bunch of kernel-doc issues
  staging: ks7010: ks_hostif: Remove a bunch of unused variables
  staging: fwserial: Demote a whole host of kernel-doc abuses
  staging: sm750fb: sm750_accel: Provide description for 'accel' and fix
    function naming
  staging: most: net: Fix some kernel-doc formatting issues
  staging: vt6655: upc: Suppress set but not used warning in macro
  staging: rtl8192u: ieee80211_softmac: Move a large data struct onto
    the heap
  staging: most: dim2: Provide missing descriptions and fix doc-rot
  staging: rtl8723bs: core: rtw_ieee80211: Remove seemingly pointless
    copy
  staging: rtl8723bs: core: rtw_mlme: 'retry' is only used if REJOIN is
    set
  staging: rtl8723bs: core: rtw_mlme_ext: 'evt_seq' is only used if
    CHECK_EVENT_SEQ is set
  staging: most: i2c: Fix a little doc-rot
  staging: most: dim2: hal: Fix one kernel-doc header and demote two
    non-conforming ones
  staging: most: dim2: hal: Demote non-conformant kernel-doc headers
  staging: axis-fifo: axis-fifo: Fix some formatting issues
  staging: rtl8188eu: os_dep: ioctl_linux: Move 2 large data buffers
    into the heap
  staging: fbtft: fb_ili9320: Remove unused variable 'ret'
  staging: rtl8723bs: core: rtw_ieee80211: Fix incorrectly named
    function
  staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable and
    dead code
  staging: rtl8188eu: os_dep: mon: Demote non-conforming kernel-doc
    headers
  staging: rtl8188eu: os_dep: rtw_android: Demote kernel-doc abuse
  staging: rtl8723bs: hal: rtl8723b_hal_init: Remove unused variable and
    dead code
  staging: rtl8723bs: hal: rtl8723b_phycfg: Fix a bunch of misnamed
    functions
  staging: rtl8723bs: hal: sdio_halinit: 'start' is only used if debug
    is enabled
  staging: rtl8723bs: hal: sdio_ops: Mark used 'err' as __maybe_unused
    and remove another
  staging: rtl8723bs: os_dep: ioctl_cfg80211: 'ack' is used when debug
    is enabled
  staging: comedi: drivers: jr3_pci: Remove set but unused variable
    'min_full_scale'
  staging: comedi: drivers: ni_tio: Fix slightly broken kernel-doc and
    demote others
  staging: comedi: drivers: ni_routes: Demote non-conforming kernel-doc
    headers
  staging: axis-fifo: axis-fifo: Fix function naming in the
    documentation
  staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable
    'func_start'
  staging: rtl8723bs: core: rtw_mlme_ext: Move very large data buffer
    onto the heap
  staging: rtl8723bs: hal: rtl8723b_hal_init: Mark a bunch of debug
    variables as __maybe_unused
  staging: comedi: drivers: ni_mio_common: Move 'range_ni_E_ao_ext' to
    where it is used
  staging: comedi: drivers: comedi_isadma: Fix misspelling of
    'dma_chan1'
  staging: rtl8723bs: hal: sdio_halinit: Remove unused variable 'ret'

 drivers/staging/android/ashmem.c              |   1 +
 drivers/staging/axis-fifo/axis-fifo.c         |  18 +--
 drivers/staging/comedi/drivers/comedi_8254.c  |   3 +-
 .../staging/comedi/drivers/comedi_isadma.c    |   2 +-
 drivers/staging/comedi/drivers/jr3_pci.c      |   3 +-
 .../staging/comedi/drivers/ni_mio_common.c    |   9 --
 drivers/staging/comedi/drivers/ni_routes.c    |   6 +-
 drivers/staging/comedi/drivers/ni_stc.h       |   9 +-
 drivers/staging/comedi/drivers/ni_tio.c       |  12 +-
 drivers/staging/fbtft/fb_ili9320.c            |   3 +-
 drivers/staging/fwserial/fwserial.c           |  46 +++----
 drivers/staging/iio/frequency/ad9834.c        |   5 +-
 drivers/staging/ks7010/ks_hostif.c            |  14 +-
 drivers/staging/most/dim2/dim2.c              |  23 ++--
 drivers/staging/most/dim2/hal.c               |  10 +-
 drivers/staging/most/i2c/i2c.c                |  12 +-
 drivers/staging/most/net/net.c                |   6 +-
 drivers/staging/nvec/nvec.c                   |   7 +-
 drivers/staging/octeon/ethernet-tx.c          |   1 -
 drivers/staging/qlge/qlge_main.c              |   4 +-
 .../staging/rtl8188eu/core/rtw_ieee80211.c    |   2 +-
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    |   8 ++
 drivers/staging/rtl8188eu/core/rtw_security.c |  10 +-
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   8 --
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    |  12 +-
 drivers/staging/rtl8188eu/os_dep/mon.c        |   6 +-
 .../staging/rtl8188eu/os_dep/rtw_android.c    |   2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |   9 +-
 drivers/staging/rtl8192u/r8192U_core.c        |  11 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c      |  41 ------
 drivers/staging/rtl8192u/r819xU_phy.c         |  48 +++++--
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c    |  29 ++--
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h    | 127 ------------------
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |   6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  17 +--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  19 +--
 drivers/staging/rtl8723bs/core/rtw_recv.c     |   2 +-
 drivers/staging/rtl8723bs/core/rtw_security.c |   2 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  10 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |   4 +-
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |   9 +-
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  21 +--
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  10 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |   8 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |   7 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   2 +-
 drivers/staging/sm750fb/sm750_accel.c         |   4 +-
 drivers/staging/vt6655/upc.h                  |   2 +-
 drivers/staging/wlan-ng/cfg80211.c            |  30 +++--
 49 files changed, 256 insertions(+), 404 deletions(-)

Cc: ac100@lists.launchpad.net
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: Andres Klode <jak@jak-linux.org>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Comedi <comedi@comedi.org>
Cc: "David A. Schleef" <ds@schleef.org>
Cc: dri-devel@lists.freedesktop.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>
Cc: Forest Bond <forest@alittletooquiet.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herman.Bruyninckx@mech.kuleuven.ac.be
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: Ilya Petrov <ilya.muromec@gmail.com>
Cc: Jacob Feder <jacobsfeder@gmail.com>
Cc: Jerry chuang <wlanfae@realtek.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: "J.P. Mellor" <jpmellor@rose-hulman.edu>
Cc: karthik alapati <mail@karthek.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kernel Team <ac100@lists.lauchpad.net>
Cc: Klaas.Gadeyne@mech.kuleuven.ac.be
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: linux-tegra@vger.kernel.org
Cc: Marc Dietrich <marvin24@gmx.de>
Cc: Marco Cesati <marcocesati@gmail.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Mori Hess <fmhess@users.sourceforge.net>
Cc: "Nícolas F. R. A. Prado" <nfraprado@protonmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre-Hugues Husson <phhusson@free.fr>
Cc: Robert Love <rlove@google.com>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Ross Schmidt <ross.schm.dev@gmail.com>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
Cc: Stanley@BB.SD3
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@android.com>
Cc: Truxton Fulton <trux@truxton.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Wim.Meeussen@mech.kuleuven.ac.be
Cc: WLAN FAE <wlanfae@realtek.com>
Cc: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
-- 
2.27.0

