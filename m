Return-Path: <linux-pwm+bounces-8329-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA85NZFcv2ms3QMAu9opvQ
	(envelope-from <linux-pwm+bounces-8329-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 04:05:53 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326C2E808B
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 04:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 768BF3014415
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47837CD36;
	Sun, 22 Mar 2026 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+TRDCZJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672411CBA;
	Sun, 22 Mar 2026 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774148749; cv=none; b=UkRUqOkdHFqUs+Gd6iHKU8HvJa8y7R8rtkuYQ7T2mKE6lFM4pyITxA7t68wFiVkt0ptAj2p0sP+pApZf5mSSjIWU+AlY3IpLQjl3AW6CzshSk/SXwwxNrWdTJUTR/GoXfbN7rettvOR5GFWyU6Ba13LytHZ57vztF7mE0jMXV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774148749; c=relaxed/simple;
	bh=VMkkKrN/cGKbWAacN7ZpmF4BdLdsuj5FwYzcdoKlfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE+L94QkIXitV8oSlE6SS54kdawQQntaM6MI+ZxSdF9ihRZ0Z0gX5hsQ5/CSu7jDrKszRUCJpqIkxEA1MEhrhe56N8Fc0cTD5CnVz1ScbNqCUuRm5ORV0jjkKf/jGi6ma9fZdUzKiHqhx1tXxyeFCn6bep6f2aWOYJlm2jdeAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+TRDCZJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774148747; x=1805684747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VMkkKrN/cGKbWAacN7ZpmF4BdLdsuj5FwYzcdoKlfWk=;
  b=f+TRDCZJzwRMnLdGsMo4+dJocHUxbmBrwxqklZ3fS1gv27v/CMOcHdrY
   ueN680uX89JjLmwENbFzwqlgcRDuQmVBuTdTh2rykry7CUJdPRz8HwgZs
   5W72jTUyszmmWggeClrTV70P2brNfC9/483JasHzwwE1W1TTDxQx7xw4X
   3ndItvnwQj8RGA/cG7zQhcpaxBRIAkuVLjtzyoOz5bR5OrJmmyj01l4kA
   IV3H5IbxQouPJbcv9mxzQNMHwsaovgr+MY14WnH3TS4oXWOLzpaOi2V+2
   W+QdCYRaBgvNqpnPgPvFE3X2Iak/LEHfFki/cGPxAs/0HZ9dMZn+VR3Rn
   w==;
X-CSE-ConnectionGUID: kH4f5nI8RMWCTuUH8wzbpQ==
X-CSE-MsgGUID: DECdhpl4SByzaraOOxL7Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="100643296"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="100643296"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 20:05:46 -0700
X-CSE-ConnectionGUID: /HkuUnGlSAywlXUWkCZfyA==
X-CSE-MsgGUID: t1wsWAmCTPOMxuGcAnBFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="223645830"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 21 Mar 2026 20:05:41 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4988-000000001ZJ-3pbJ;
	Sun, 22 Mar 2026 03:05:34 +0000
Date: Sun, 22 Mar 2026 11:05:31 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <202603221011.rzczUvUN-lkp@intel.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8329-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,metafoo.de,analog.com,baylibre.com,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url]
X-Rspamd-Queue-Id: 9326C2E808B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau-via-B4-Relay/dt-bindings-iio-adc-add-AD4691-family/20260321-120718
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a%40analog.com
patch subject: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
config: nios2-randconfig-r122-20260322 (https://download.01.org/0day-ci/archive/20260322/202603221011.rzczUvUN-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221011.rzczUvUN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221011.rzczUvUN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad4691.c:954:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/iio/adc/ad4691.c:954:39: sparse:     expected unsigned int
   drivers/iio/adc/ad4691.c:954:39: sparse:     got restricted __be32 [usertype]
   drivers/iio/adc/ad4691.c:970:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/iio/adc/ad4691.c:970:31: sparse:     expected unsigned int
   drivers/iio/adc/ad4691.c:970:31: sparse:     got restricted __be32 [usertype]
   drivers/iio/adc/ad4691.c:1059:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/iio/adc/ad4691.c:1059:39: sparse:     expected unsigned int
   drivers/iio/adc/ad4691.c:1059:39: sparse:     got restricted __be32 [usertype]
>> drivers/iio/adc/ad4691.c:1072:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offload_tx_reset @@     got restricted __be32 [usertype] @@
   drivers/iio/adc/ad4691.c:1072:30: sparse:     expected unsigned int [usertype] offload_tx_reset
   drivers/iio/adc/ad4691.c:1072:30: sparse:     got restricted __be32 [usertype]

vim +954 drivers/iio/adc/ad4691.c

   927	
   928	static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
   929	{
   930		struct ad4691_state *st = iio_priv(indio_dev);
   931		struct device *dev = regmap_get_device(st->regmap);
   932		struct spi_device *spi = to_spi_device(dev);
   933		struct spi_offload_trigger_config config = {
   934			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
   935		};
   936		unsigned int bit, k;
   937		int ret;
   938	
   939		ret = ad4691_enter_conversion_mode(st);
   940		if (ret)
   941			return ret;
   942	
   943		memset(st->offload_xfer, 0, sizeof(st->offload_xfer));
   944	
   945		/*
   946		 * N+1 transfers for N channels. Each CS-low period triggers
   947		 * a conversion AND returns the previous result (pipelined).
   948		 *   TX: [AD4691_ADC_CHAN(n), 0x00, 0x00, 0x00]
   949		 *   RX: [data_hi, data_lo, 0x00, 0x00]   (shift=16)
   950		 * Transfer 0 RX is garbage; transfers 1..N carry real data.
   951		 */
   952		k = 0;
   953		iio_for_each_active_channel(indio_dev, bit) {
 > 954			st->offload_tx_cmd[k] =
   955				cpu_to_be32(FIELD_PREP(AD4691_MSG_ADDR_HI,
   956						       AD4691_ADC_CHAN(bit)));
   957			st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
   958			st->offload_xfer[k].len = sizeof(u32);
   959			st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
   960			st->offload_xfer[k].cs_change = 1;
   961			st->offload_xfer[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
   962			st->offload_xfer[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
   963			/* First transfer RX is garbage — skip it. */
   964			if (k > 0)
   965				st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
   966			k++;
   967		}
   968	
   969		/* Final NOOP to flush pipeline and capture last channel. */
   970		st->offload_tx_cmd[k] =
   971			cpu_to_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_NOOP));
   972		st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
   973		st->offload_xfer[k].len = sizeof(u32);
   974		st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
   975		st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
   976		k++;
   977	
   978		spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer, k);
   979		st->offload_msg.offload = st->offload;
   980	
   981		ret = spi_optimize_message(spi, &st->offload_msg);
   982		if (ret)
   983			goto err_exit_conversion;
   984	
   985		config.periodic.frequency_hz = st->offload_trigger_hz;
   986		ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
   987		if (ret)
   988			goto err_unoptimize;
   989	
   990		return 0;
   991	
   992	err_unoptimize:
   993		spi_unoptimize_message(&st->offload_msg);
   994	err_exit_conversion:
   995		ad4691_exit_conversion_mode(st);
   996		return ret;
   997	}
   998	
   999	static int ad4691_manual_offload_buffer_predisable(struct iio_dev *indio_dev)
  1000	{
  1001		struct ad4691_state *st = iio_priv(indio_dev);
  1002	
  1003		spi_offload_trigger_disable(st->offload, st->offload_trigger);
  1004		spi_unoptimize_message(&st->offload_msg);
  1005	
  1006		return ad4691_exit_conversion_mode(st);
  1007	}
  1008	
  1009	static const struct iio_buffer_setup_ops ad4691_manual_offload_buffer_setup_ops = {
  1010		.postenable = &ad4691_manual_offload_buffer_postenable,
  1011		.predisable = &ad4691_manual_offload_buffer_predisable,
  1012	};
  1013	
  1014	static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
  1015	{
  1016		struct ad4691_state *st = iio_priv(indio_dev);
  1017		struct device *dev = regmap_get_device(st->regmap);
  1018		struct spi_device *spi = to_spi_device(dev);
  1019		struct spi_offload_trigger_config config = {
  1020			.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
  1021		};
  1022		unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);
  1023		unsigned int bit, k;
  1024		int ret;
  1025	
  1026		ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
  1027				   (u16)~(*indio_dev->active_scan_mask));
  1028		if (ret)
  1029			return ret;
  1030	
  1031		ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
  1032				   *indio_dev->active_scan_mask);
  1033		if (ret)
  1034			return ret;
  1035	
  1036		iio_for_each_active_channel(indio_dev, bit) {
  1037			ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
  1038					   AD4691_ACC_COUNT_VAL);
  1039			if (ret)
  1040				return ret;
  1041		}
  1042	
  1043		ret = ad4691_enter_conversion_mode(st);
  1044		if (ret)
  1045			return ret;
  1046	
  1047		memset(st->offload_xfer, 0, sizeof(st->offload_xfer));
  1048	
  1049		/*
  1050		 * N transfers to read N AVG_IN registers plus one state-reset
  1051		 * transfer (no RX) to re-arm DATA_READY.
  1052		 *   TX: [reg_hi | 0x80, reg_lo, 0x00, 0x00]
  1053		 *   RX: [0x00, 0x00, data_hi, data_lo]   (shift=0)
  1054		 */
  1055		k = 0;
  1056		iio_for_each_active_channel(indio_dev, bit) {
  1057			unsigned int reg = AD4691_AVG_IN(bit);
  1058	
  1059			st->offload_tx_cmd[k] =
  1060				cpu_to_be32(((reg >> 8 | 0x80) << 24) |
  1061					    ((reg & 0xFF) << 16));
  1062			st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
  1063			st->offload_xfer[k].len = sizeof(u32);
  1064			st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
  1065			st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
  1066			if (k < n_active - 1)
  1067				st->offload_xfer[k].cs_change = 1;
  1068			k++;
  1069		}
  1070	
  1071		/* State reset to re-arm DATA_READY for the next scan. */
> 1072		st->offload_tx_reset =
  1073			cpu_to_be32(((AD4691_STATE_RESET_REG >> 8) << 24) |
  1074				    ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
  1075				    (AD4691_STATE_RESET_ALL << 8));
  1076		st->offload_xfer[k].tx_buf = &st->offload_tx_reset;
  1077		st->offload_xfer[k].len = sizeof(u32);
  1078		st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
  1079		k++;
  1080	
  1081		spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer, k);
  1082		st->offload_msg.offload = st->offload;
  1083	
  1084		ret = spi_optimize_message(spi, &st->offload_msg);
  1085		if (ret)
  1086			goto err_exit_conversion;
  1087	
  1088		ret = ad4691_sampling_enable(st, true);
  1089		if (ret)
  1090			goto err_unoptimize;
  1091	
  1092		ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
  1093		if (ret)
  1094			goto err_sampling_disable;
  1095	
  1096		return 0;
  1097	
  1098	err_sampling_disable:
  1099		ad4691_sampling_enable(st, false);
  1100	err_unoptimize:
  1101		spi_unoptimize_message(&st->offload_msg);
  1102	err_exit_conversion:
  1103		ad4691_exit_conversion_mode(st);
  1104		return ret;
  1105	}
  1106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

