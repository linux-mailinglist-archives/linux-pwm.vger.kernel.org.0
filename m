Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45255F79
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 05:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZD2I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 23:28:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41056 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZD2I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 23:28:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so483486qkk.8
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jun 2019 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlIkKY0VE4UqMnVtVIxb3XZhsV7CFBjXdZOzFNVmjwQ=;
        b=PBgGri57J+namPVw3UWYzE6Xn3Dn4Ve5NzK5s+f2/+otN6oz+Lv7izvt9X6CGprg2u
         EAvaiOpedaPFTWKF/xLLPTqZ3e8FqT84R/uUWio2yl3OJLA6roHARWyphg/OlcSMYxr/
         I4PnptxsppenIonUS6g27n26BFSNZaz2a29Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlIkKY0VE4UqMnVtVIxb3XZhsV7CFBjXdZOzFNVmjwQ=;
        b=Ciw//fuMuzgm6zU3XzTAALy5rDBUq9dieT+E8DjXfSOQw7v0CynH2YPKz79Sby1KXN
         qGLeOVIwyQroMAmgRmc0gFjggX0y6p1aKNuhdSQJ1fD0qTuswmDcijJsFR2tj88i8I8y
         /2LM0slhmHm/jcmJmqRFXVqwNfGGCfRtQYIdmB4ff0vif8WeUW4Ak9tyHgu6Ce99aA4K
         TiWO9BURYC7Xzy06GkAYALocCb7RjV1u3kmVTP1Hkc7VE7uoE1cRiD60gfhynLjY62Xz
         0tlomb4XQuA/Eg8u/Q56F383DOJR/mFUKd2c9WnPIgE178lbY6xtZhmesTbDR94mnv8A
         DF/g==
X-Gm-Message-State: APjAAAX8AeiQ7/o3qau5AD7vDzl+N1iTVD30Qw3bzdOaI9p2l5kyhxAO
        mI6C3Hlmpy4YOxumUbJUiG6LnIc10qJ8ZYq9FjQsRg==
X-Google-Smtp-Source: APXvYqwDKogS8o5rvv6VsMtBInKsGCSOaLrukp/+xNnyXzXpIK8IkDIKd8ynvgJG18juR7dfr4SeXzcpeEPLQvmJLqk=
X-Received: by 2002:a37:660b:: with SMTP id a11mr1810032qkc.342.1561519686671;
 Tue, 25 Jun 2019 20:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190624060343.62451-1-jitao.shi@mediatek.com> <20190624060343.62451-3-jitao.shi@mediatek.com>
In-Reply-To: <20190624060343.62451-3-jitao.shi@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 26 Jun 2019 11:27:40 +0800
Message-ID: <CAJMQK-jOgkRzYOTsiuUY4X8hzcGQL0XRiJSs7giiShnRb=nO_A@mail.gmail.com>
Subject: Re: [v2 2/2] drm/panel: support for BOE tv101wum-nl6 wuxga dsi video
 mode panel
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 24, 2019 at 6:03 AM Jitao Shi <jitao.shi@mediatek.com> wrote:

There are some error when unbinding this driver,
`` echo 14014000.dsi.0 >
/sys/bus/mipi-dsi/drivers/panel-boe-tv101wum-nl6/unbind ``

[   40.404393] WARNING: CPU: 1 PID: 2612 at
/mnt/host/source/src/third_party/kernel/v4.19/drivers/regulator/core.c:2054
_regulator_put+0xe4/0xec
[   40.417098] Modules linked in: rfcomm uinput thermal_generic_adc
hci_uart btqca bluetooth ecdh_generic mtk_scp mtk_rpmsg mtk_scp_ipi
bridge rpmsg_core mt6577_auxadc stp llc nf_nat_tftp nv
[   40.471107] CPU: 1 PID: 2612 Comm: bash Tainted: G S
4.19.53 #99
[   40.478410] Hardware name: MediaTek krane rev3 sku16 board (DT)
[   40.484327] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   40.489118] pc : _regulator_put+0xe4/0xec
[   40.493127] lr : regulator_put+0x2c/0x40
[   40.497044] sp : ffffff800cef3b00
[   40.500354] x29: ffffff800cef3b10 x28: fffffff0e7a22a00
[   40.505667] x27: 0000000000000000 x26: fffffff13876fc00
[   40.510979] x25: ffffff800cef3b68 x24: ffffff91f0b92000
[   40.516291] x23: ffffff91f03f2917 x22: ffffff91f0453a1c
[   40.521604] x21: fffffff13876fe00 x20: ffffff91f0a80988
[   40.526916] x19: fffffff13876ff00 x18: 0000000000000000
[   40.532229] x17: 0000000000000000 x16: 0000000000000000
[   40.537541] x15: 0000000000000000 x14: 0000000000000000
[   40.542854] x13: 0000000000000010 x12: 0000000000000000
[   40.548166] x11: 0000000000000000 x10: 0000000000000000
[   40.553478] x9 : fffffff0e7a22a00 x8 : 0000000000000001
[   40.558789] x7 : 0004be4200000000 x6 : 0000000042be0400
[   40.564102] x5 : ffffff91f043a5ef x4 : ffffff91f043a5ef
[   40.569414] x3 : 0000000000000000 x2 : 0000000000000000
[   40.574726] x1 : 00000000000000fe x0 : fffffff13876ff00
[   40.580040] Call trace:
[   40.582488]  _regulator_put+0xe4/0xec
[   40.586148]  regulator_put+0x2c/0x40
[   40.589724]  devm_regulator_release+0x1c/0x28
[   40.594084]  release_nodes+0x1f0/0x244
[   40.597832]  devres_release_all+0x3c/0x54
[   40.601840]  device_release_driver_internal+0x148/0x1ec
[   40.607061]  device_release_driver+0x24/0x30
[   40.611328]  unbind_store+0x90/0xdc
[   40.614814]  drv_attr_store+0x3c/0x54
[   40.618478]  sysfs_kf_write+0x50/0x68
[   40.622137]  kernfs_fop_write+0x12c/0x1c8
[   40.626146]  __vfs_write+0x54/0x15c
[   40.629631]  vfs_write+0xcc/0x188
[   40.632943]  ksys_write+0x78/0xd8
[   40.636255]  __arm64_sys_write+0x20/0x2c
[   40.640181]  el0_svc_common+0xa4/0x154
[   40.643928]  el0_svc_compat_handler+0x2c/0x38
[   40.648283]  el0_svc_compat+0x8/0x18
[   40.651855] ---[ end trace 65d8c8e7436ab6e9 ]---
[   40.656765] panel-boe-tv101wum-nl6 14014000.dsi.0: Dropping the
link to regulator.8
[   40.664649] WARNING: CPU: 6 PID: 2612 at
/mnt/host/source/src/third_party/kernel/v4.19/drivers/regulator/core.c:2054
_regulator_put+0xe4/0xec
[   40.677335] Modules linked in: rfcomm uinput thermal_generic_adc
hci_uart btqca bluetooth ecdh_generic mtk_scp mtk_rpmsg mtk_scp_ipi
bridge rpmsg_core mt6577_auxadc stp llc nf_nat_tftp nv
[   40.731273] CPU: 6 PID: 2612 Comm: bash Tainted: G S      W
4.19.53 #99
[   40.738574] Hardware name: MediaTek krane rev3 sku16 board (DT)
[   40.744488] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   40.749276] pc : _regulator_put+0xe4/0xec
[   40.753282] lr : regulator_put+0x2c/0x40
[   40.757197] sp : ffffff800cef3b00
[   40.760505] x29: ffffff800cef3b10 x28: fffffff0e7a22a00
[   40.765814] x27: 0000000000000000 x26: fffffff13876fa00
[   40.771122] x25: ffffff800cef3b68 x24: ffffff91f0b92000
[   40.776429] x23: ffffff91f03f2917 x22: ffffff91f0453a1c
[   40.781736] x21: fffffff13876fc00 x20: ffffff91f0a80988
[   40.787044] x19: fffffff13876fd00 x18: 0000000000000020
[   40.792351] x17: 0000000000000001 x16: 0000000000000000
[   40.797658] x15: 0000000000000000 x14: 00000000000003f1
[   40.802966] x13: 0000000000000004 x12: 000000001f80c232
[   40.808272] x11: 0000000000000000 x10: 0000000000000001
[   40.813580] x9 : 7ee042d282bebd00 x8 : 0000000000000001
[   40.818887] x7 : fefeff2f2f37306f x6 : 0000000000000000
[   40.824194] x5 : 0000000000000000 x4 : ffffff91f0143fdc
[   40.829501] x3 : 0000000000000000 x2 : 0000000000000000
[   40.834809] x1 : 000000000000038c x0 : fffffff13876fd00
[   40.840116] Call trace:
[   40.842560]  _regulator_put+0xe4/0xec
[   40.846218]  regulator_put+0x2c/0x40
[   40.849791]  devm_regulator_release+0x1c/0x28
[   40.854148]  release_nodes+0x1f0/0x244
[   40.857892]  devres_release_all+0x3c/0x54
[   40.861898]  device_release_driver_internal+0x148/0x1ec
[   40.867116]  device_release_driver+0x24/0x30
[   40.871380]  unbind_store+0x90/0xdc
[   40.874863]  drv_attr_store+0x3c/0x54
[   40.878524]  sysfs_kf_write+0x50/0x68
[   40.882180]  kernfs_fop_write+0x12c/0x1c8
[   40.886186]  __vfs_write+0x54/0x15c
[   40.889668]  vfs_write+0xcc/0x188
[   40.892978]  ksys_write+0x78/0xd8
[   40.896287]  __arm64_sys_write+0x20/0x2c
[   40.900208]  el0_svc_common+0xa4/0x154
[   40.903951]  el0_svc_compat_handler+0x2c/0x38
[   40.908302]  el0_svc_compat+0x8/0x18
[   40.911871] ---[ end trace 65d8c8e7436ab6ea ]---
[   40.916642] panel-boe-tv101wum-nl6 14014000.dsi.0: Dropping the
link to regulator.7
[   40.924511] WARNING: CPU: 6 PID: 2612 at
/mnt/host/source/src/third_party/kernel/v4.19/drivers/regulator/core.c:2054
_regulator_put+0xe4/0xec
[   40.937193] Modules linked in: rfcomm uinput thermal_generic_adc
hci_uart btqca bluetooth ecdh_generic mtk_scp mtk_rpmsg mtk_scp_ipi
bridge rpmsg_core mt6577_auxadc stp llc nf_nat_tftp nv
[   40.991108] CPU: 6 PID: 2612 Comm: bash Tainted: G S      W
4.19.53 #99
[   40.998407] Hardware name: MediaTek krane rev3 sku16 board (DT)
[   41.004320] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   41.009105] pc : _regulator_put+0xe4/0xec
[   41.013109] lr : regulator_put+0x2c/0x40
[   41.017022] sp : ffffff800cef3b00
[   41.020329] x29: ffffff800cef3b10 x28: fffffff0e7a22a00
[   41.025636] x27: 0000000000000000 x26: fffffff13876f900
[   41.030942] x25: ffffff800cef3b68 x24: ffffff91f0b92000
[   41.036248] x23: ffffff91f03f2917 x22: ffffff91f0453a1c
[   41.041554] x21: fffffff13876fa00 x20: ffffff91f0a80988
[   41.046859] x19: fffffff13876fb00 x18: 0000000000000020
[   41.052166] x17: 0000000000000001 x16: 0000000000000000
[   41.057472] x15: 00000000ffffffff x14: 00000000000002e3
[   41.062778] x13: 0000000000000000 x12: 0000000000000000
[   41.068084] x11: 0000000000000000 x10: 00000000ffffffff
[   41.073389] x9 : 7ee042d282bebd00 x8 : 0000000000000001
[   41.078696] x7 : 0000000000000000 x6 : ffffff800cef37f0
[   41.084002] x5 : 0000000000000040 x4 : 0000000000000000
[   41.089307] x3 : 0000000000000000 x2 : fffffff0e7a22ac0
[   41.094613] x1 : 0000000000000000 x0 : fffffff13876fb00
[   41.099918] Call trace:
[   41.102361]  _regulator_put+0xe4/0xec
[   41.106017]  regulator_put+0x2c/0x40
[   41.109587]  devm_regulator_release+0x1c/0x28
[   41.113939]  release_nodes+0x1f0/0x244
[   41.117683]  devres_release_all+0x3c/0x54
[   41.121686]  device_release_driver_internal+0x148/0x1ec
[   41.126904]  device_release_driver+0x24/0x30
[   41.131167]  unbind_store+0x90/0xdc
[   41.134649]  drv_attr_store+0x3c/0x54
[   41.138308]  sysfs_kf_write+0x50/0x68
[   41.141962]  kernfs_fop_write+0x12c/0x1c8
[   41.145965]  __vfs_write+0x54/0x15c
[   41.149446]  vfs_write+0xcc/0x188
[   41.152754]  ksys_write+0x78/0xd8
[   41.156061]  __arm64_sys_write+0x20/0x2c
[   41.159979]  el0_svc_common+0xa4/0x154
[   41.163722]  el0_svc_compat_handler+0x2c/0x38
[   41.168072]  el0_svc_compat+0x8/0x18
[   41.171640] ---[ end trace 65d8c8e7436ab6eb ]---
[   41.176405] panel-boe-tv101wum-nl6 14014000.dsi.0: Dropping the
link to regulator.6

Also, sometimes when rebinding the driver
`` echo 14014000.dsi.0 >
/sys/bus/mipi-dsi/drivers/panel-boe-tv101wum-nl6/bind ``
UI still failed to show up.
