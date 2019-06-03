Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEC3267A
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFCCNj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 22:13:39 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12130 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726561AbfFCCNj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Jun 2019 22:13:39 -0400
X-UUID: 7a5dfea062b440a8b7d89b1ba2c134ba-20190603
X-UUID: 7a5dfea062b440a8b7d89b1ba2c134ba-20190603
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1662302038; Mon, 03 Jun 2019 10:13:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Jun 2019 10:13:30 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Jun 2019 10:13:29 +0800
Message-ID: <1559528009.32185.3.camel@mtksdaap41>
Subject: Re: [v4 2/7] drm/mediatek: fixes CMDQ reg address of mt8173 is
 different with mt2701
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Thierry Reding" <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        "Inki Dae" <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        "Sean Paul" <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        "Andy Yan" <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <stonea168@163.com>
Date:   Mon, 3 Jun 2019 10:13:29 +0800
In-Reply-To: <20190601092615.67917-3-jitao.shi@mediatek.com>
References: <20190601092615.67917-1-jitao.shi@mediatek.com>
         <20190601092615.67917-3-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Sat, 2019-06-01 at 17:26 +0800, Jitao Shi wrote:
> Config the different CMDQ reg address in driver data.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 6c4ac37f983d..a48db056df6c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -131,7 +131,6 @@
>  #define VM_CMD_EN			BIT(0)
>  #define TS_VFP_EN			BIT(5)
>  
> -#define DSI_CMDQ0		0x180
>  #define CONFIG				(0xff << 0)
>  #define SHORT_PACKET			0
>  #define LONG_PACKET			2
> @@ -156,6 +155,10 @@
>  
>  struct phy;
>  
> +struct mtk_dsi_driver_data {
> +	const u32 reg_cmdq_off;
> +};
> +
>  struct mtk_dsi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct device *dev;
> @@ -182,6 +185,7 @@ struct mtk_dsi {
>  	bool enabled;
>  	u32 irq_data;
>  	wait_queue_head_t irq_wait_queue;
> +	const struct mtk_dsi_driver_data *driver_data;
>  };
>  
>  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> @@ -934,6 +938,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>  	const char *tx_buf = msg->tx_buf;
>  	u8 config, cmdq_size, cmdq_off, type = msg->type;
>  	u32 reg_val, cmdq_mask, i;
> +	u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
>  
>  	if (MTK_DSI_HOST_IS_READ(type))
>  		config = BTA;
> @@ -953,9 +958,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>  	}
>  
>  	for (i = 0; i < msg->tx_len; i++)
> -		writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> +		mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> +			     (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> +			     tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));

I've modify this line to

writeb(tx_buf[i], dsi->regs + reg_cmdq_off + cmdq_off + i);

and this works. The call trace list below

[    8.189067] Call trace:
[    8.191516]  dump_backtrace+0x0/0x164
[    8.195172]  show_stack+0x20/0x2c
[    8.198482]  dump_stack+0xc4/0xfc
[    8.201792]  mtk_dsi_host_transfer+0x248/0x4ac
[    8.206230]  mipi_dsi_device_transfer+0x50/0x64
[    8.210753]  mipi_dsi_dcs_exit_sleep_mode+0x5c/0x8c
[    8.215625]  innolux_panel_prepare+0x128/0x218
[    8.220061]  mtk_dsi_poweron+0x74c/0x7c8
[    8.223976]  mtk_dsi_ddp_start+0x1c/0x28
[    8.227891]  mtk_drm_crtc_atomic_enable+0x310/0x428
[    8.232765]  drm_atomic_helper_commit_modeset_enables+0xa0/0x200
[    8.238764]  mtk_atomic_complete+0x84/0xd0
[    8.242852]  mtk_atomic_commit+0xb8/0xe0
[    8.246769]  drm_atomic_commit+0x50/0x5c
[    8.250684]  drm_atomic_helper_set_config+0x98/0xa0
[    8.255555]  drm_mode_setcrtc+0x280/0x618
[    8.259558]  drm_ioctl_kernel+0xcc/0x10c
[    8.263473]  drm_ioctl+0x248/0x3d4
[    8.266868]  drm_compat_ioctl+0xd8/0xe8
[    8.270698]  __arm64_compat_sys_ioctl+0xf4/0x25c
[    8.275309]  el0_svc_common+0x9c/0xfc
[    8.278965]  el0_svc_compat_handler+0x2c/0x38
[    8.283314]  el0_svc_compat+0x8/0x18

So I think writeb() could work correctly. If you have meet some problem,
it might be other problem.

Regards,
CK

>  
> -	mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> +	mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
>  	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
>  }
>  
> @@ -1101,6 +1108,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_host;
>  
> +	dsi->driver_data = of_device_get_match_data(dev);
> +
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>  	if (IS_ERR(dsi->engine_clk)) {
>  		ret = PTR_ERR(dsi->engine_clk);
> @@ -1193,9 +1202,19 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> +	.reg_cmdq_off = 0x200,
> +};
> +
> +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> +	.reg_cmdq_off = 0x180,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
> -	{ .compatible = "mediatek,mt2701-dsi" },
> -	{ .compatible = "mediatek,mt8173-dsi" },
> +	{ .compatible = "mediatek,mt2701-dsi",
> +	  .data = &mt2701_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8173-dsi",
> +	  .data = &mt8173_dsi_driver_data },
>  	{ },
>  };
>  


