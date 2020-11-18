Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8C2B833D
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKRRmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:42:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:30503 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgKRRmc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 12:42:32 -0500
IronPort-SDR: r9PVIkTKYeBo2iihI4kN2x82fYBFSy7H5J1d9HyBCnmhU1rjSH5MgNplFDDHYls/z17NomM+Gw
 63rnm9KGlDRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="235302930"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="235302930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 09:42:30 -0800
IronPort-SDR: NaAXGrwlIdR+oSF9BbsnfrMzAiBcTFdFuHMRotyV+zdUYgSf9u/dmwcwVMYtGPiox7ENYSPxI0
 L4RJ4+lQpjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="544631188"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 09:42:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 09:42:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Nov 2020 09:42:30 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 18 Nov 2020 09:42:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZZyeHB+fd08KQOvsHrZZRjPt6fl1dX0o+FPv+hWOiYEQr6re719R63wQYIGSGaYu3Lru9l3TCLAFiOja5TwML21JHOVvVsWeCTbkViMaPBUS4VvigxR4GQVjzBxM8lYPIw4GZB2uDW5a7CO4y0rJmiH9HORu4ewM/GqeagHSy7Jq2IghD6IM3cy3utszNcAfmzgPZ/tAfpxS7JOP3n0cZKjlKqWY7mecXNBpluFFERr8pCjlDXCrVEEYXEL875muguhS4Hk73EnSX0uKp+BhwLz5/iuZYnBqZOdN2BJVfbbV6Nu2ayYni4gU+9X2agvj5Gxvo/OOQTPjE6+oga/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA6ckejJ0GpQVty4MZi8OSCuolj6nzGNmZcHy3HJrFM=;
 b=HNmC2ItAr+8L9yiLukR+PuqMnAIrJHkqrXTf/ay/4hqtoU4mEyIRWaBDtkynJY40szneINp/HobbEhN94rmJaZPpPjKBllBjlfMVH4DYPnmy9zAObrR9pdT3lAKCog+DqF1FxtFKkcDehYvewuPF6mhNwfzYNASqwpY9gfpVJvJV7/P1WbOAGV34v3UKZpfIer4p5NGV6Ik6ZKN6pagrJ0ddIRhwIf3U+EMw3yLora8aTE97XymK/BNkQ+LLC7OMcdIc1DNpkMUcoPBggySC+JTm+ZJBLUAFdlOj6POOp7wEcxKu9F3qEdZww825LtmI3gtXNx6syj82NB1JOhESRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA6ckejJ0GpQVty4MZi8OSCuolj6nzGNmZcHy3HJrFM=;
 b=SMdJKhIeoCnA1ntgxrq1LYlLlyA9R+nS/lhzPd81/4RMFwvvHm/zXMtryWo0KCE6r75U8UrleaEXaVrUJGIRx7TxwhyT8u9IF0bkqwpaD0JzSxnd3vR7TN1faresLPW7O/ZS7m+/MxQiKlDU7IZch4pD1MxyLH402nuSi1sPGjo=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB4009.namprd11.prod.outlook.com (2603:10b6:5:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 17:41:57 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef%4]) with mapi id 15.20.3589.020; Wed, 18 Nov 2020
 17:41:57 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Thread-Topic: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Thread-Index: AQHWu/gOwJsV/Qehpk218Q5UlO0i2KnNrQSAgAB90uA=
Date:   Wed, 18 Nov 2020 17:41:57 +0000
Message-ID: <DM6PR11MB42509471531D8F009DB37E98FBE10@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
 <20201118100627.chgu3tgpt3kuazsv@pengutronix.de>
In-Reply-To: <20201118100627.chgu3tgpt3kuazsv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.177.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cdcfe23-733c-4dcc-3e8d-08d88be93f1e
x-ms-traffictypediagnostic: DM6PR11MB4009:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4009E9E0E341A45769A4827AFBE10@DM6PR11MB4009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHSBgD6TnvUH/7upAfJq4gUiT372lH3/2dZ+PqcrgkeoTAwsw7kG3puSDXuRH0ypnOsLwi73cn2JSFsWYzCXpNk6r3XeZ2UnIbV2TJE21yQgOfYrh2OO//MJCAKMPd9Glb2EOABHN10Gp9QEQIfUduAeezvf39etC5+ZC59eGNsavHhZ6x1MTqZi6ydLnP+mw2GjyGUSNM/RCQaI5JPbz+4pQYfps6FjU6snoumXwCaQZP8jyIoILpMrPNVzrwZoADvvzHCN/sQB50rpoP2BUdNrcKG520u+wHjk4OzW2/vdc5Ng8bvYYTqgWcivdU+bMja4nT7JAWGTh1dqJIIg2HCIEl6Dzh959ELhJwTNkM7FCc3/7Ln+wlVU4tS3bcfrICy9Z6NXUm+mDFh6ND5H3baM6s+YPix02E1mDJV+57CN1zx/ioCQ172S7lzlQ2P+zEUifYgU2GGo9B4GNqiLGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(52536014)(186003)(7696005)(64756008)(66476007)(66446008)(9686003)(26005)(71200400001)(33656002)(5660300002)(66574015)(66946007)(8676002)(316002)(76116006)(8936002)(66556008)(86362001)(2906002)(110136005)(83380400001)(54906003)(6506007)(966005)(83080400002)(4326008)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LOg/t/vmtXmv8DyQ2TqgDxxkqQqwRO1cL3WGlQYy+7bn1UHxwIm0Ord16m9Wttkfc/oiNpzcKaSFTLomZrE6jYqd45X/4J/75q7IoJgAXuZzJOTj3rxA1EowHawFpS3eIQ7Izr1SjqR46M2k+gJNiH9pM/CodqcIqtqWSrAH/vw63iAYnJgSdSnG1TQ3s9vOfosHwFdAkZDKW+ZdUMuwQq+aJS53yjzAj5NOZiNZMf/V5U9lIh6b5xYFu6NJEnpuepZ4PCdNPmQH6aLVyr30BHcWvIy7/MPq7smZrPQ1WXkTugL9UUiJTB9OPcPS4LaZtdlLmxv4qkptjHXrtJlciHmmT9W9qc+R6cvSl+qVvNOE54oe8NQG6QIRmysOUvMQI4MVTftSzZ2TqUKrRJgWwsjpQ3PdnflVi9Vwrrv4lXKCursGjfypf2mjyuNv8VQ1c7c4i5+xWDO2Ogip5OXM5rhGQ5MtecRr/3PZACSqz0Ofhnoll0KWxyvfg0h8SSvoV1eCiMaV+1J96sbVFPmdmoHONzazOV+Kzx2qJ3zUlwR0Vir7g7yHGeXxuZfS0cv0fpHO6Dgoq6JUNkD6L67ONczUzto5dnk2gDXfQZQjaxHkaSjwh5GDbG2oSshegZTtwggjNqFg5EPBUHJZ4jH9ciATCNcq0qIkVpAqcC955pO/QKtXG1aMlm6WtSqkAOgFuDJ+XzzJfa6nBzAZERTsMRg1A9P2iw6lGvjzha+fHwLCFojx+R6JlkGT5ulidxeun+3BtThdWk+P/e0S2FlOOdFCMvJ7XmOeP2Dl43qiU/h3OgZccYxdHn5d6XF5OBnN253Twzk0ezUvKXpevjl9NDZKIWDFi3b6xKcBipbaFkE+sni7kPzW9VTnvvVcSPB8wgU0oKp7HOQcpKlz0waPLw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdcfe23-733c-4dcc-3e8d-08d88be93f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 17:41:57.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niokfH1TTiN9mpIJyCPFOLk7OQLk9VhfNq+iW6AncAWGjbYT9LFbjuvTe1/BWR/pkMaQbpEiZ9CdtlkT3A/1aUFlxUJB5zOcOFVIGS3oSkrA5K9HK+ZVU5bu16IydDdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4009
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVGhpZXJyeSwNCg0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmln
QHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQ10gcHdtOiBrZWVtYmF5
OiBGaXggYnVpbGQgZmFpbHVyZSB3aXRoIC1Pcw0KPiANCj4gW0NjOiArPSBsaW51eC1wd20gd2hp
Y2ggSSBmb3Jnb3QgZm9yIHRoZSBpbml0aWFsIHN1Ym1pc3Npb25dDQo+IA0KPiBIZWxsbywNCj4g
DQo+IE9uIE1vbiwgTm92IDE2LCAyMDIwIGF0IDEwOjA4OjA0QU0gKzAxMDAsIFV3ZSBLbGVpbmUt
S8O2bmlnIHdyb3RlOg0KPiA+IFRoZSBkcml2ZXIgdXNlZCB0aGlzIGNvbnN0cnVjdDoNCj4gPg0K
PiA+IAkjZGVmaW5lIEtNQl9QV01fTEVBRElOX01BU0sgICAgICAgICAgICAgR0VOTUFTSygzMCwg
MCkNCj4gPg0KPiA+IAlzdGF0aWMgaW5saW5lIHZvaWQga2VlbWJheV9wd21fdXBkYXRlX2JpdHMo
c3RydWN0IGtlZW1iYXlfcHdtDQo+ICpwcml2LCB1MzIgbWFzaywNCj4gPiAJCQkJCQkgICB1MzIg
dmFsLCB1MzIgb2Zmc2V0KQ0KPiA+IAl7DQo+ID4gCQl1MzIgYnVmZiA9IHJlYWRsKHByaXYtPmJh
c2UgKyBvZmZzZXQpOw0KPiA+DQo+ID4gCQlidWZmID0gdTMyX3JlcGxhY2VfYml0cyhidWZmLCB2
YWwsIG1hc2spOw0KPiA+IAkJd3JpdGVsKGJ1ZmYsIHByaXYtPmJhc2UgKyBvZmZzZXQpOw0KPiA+
IAl9DQo+ID4NCj4gPiAJLi4uDQo+ID4gCWtlZW1iYXlfcHdtX3VwZGF0ZV9iaXRzKHByaXYsIEtN
Ql9QV01fTEVBRElOX01BU0ssIDAsDQo+ID4gCQkJCQlLTUJfUFdNX0xFQURJTl9PRkZTRVQocHdt
LQ0KPiA+aHdwd20pKTsNCj4gPg0KPiA+IFdpdGggQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpF
IHRoZSBjb21waWxlciAoaGVyZTogZ2NjIDEwLjIuMCkgdGhpcw0KPiA+IHRyaWdnZXJzOg0KPiA+
DQo+ID4gCUluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS91d2UvZ3NyYy9saW51eC9kcml2ZXJz
L3B3bS9wd20tDQo+IGtlZW1iYXkuYzoxNjoNCj4gPiAJSW4gZnVuY3Rpb24g4oCYZmllbGRfbXVs
dGlwbGllcuKAmSwNCj4gPiAJICAgIGlubGluZWQgZnJvbSDigJhrZWVtYmF5X3B3bV91cGRhdGVf
Yml0c+KAmSBhdA0KPiAvaG9tZS91d2UvZ3NyYy9saW51eC9pbmNsdWRlL2xpbnV4L2JpdGZpZWxk
Lmg6MTI0OjE3Og0KPiA+IAkvaG9tZS91d2UvZ3NyYy9saW51eC9pbmNsdWRlL2xpbnV4L2JpdGZp
ZWxkLmg6MTE5OjM6IGVycm9yOiBjYWxsIHRvDQo+IOKAmF9fYmFkX21hc2vigJkgZGVjbGFyZWQg
d2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGJhZCBiaXRmaWVsZCBtYXNrDQo+ID4gCSAgMTE5IHwgICBf
X2JhZF9tYXNrKCk7DQo+ID4gCSAgICAgIHwgICBefn5+fn5+fn5+fn4NCj4gPiAJSW4gZnVuY3Rp
b24g4oCYZmllbGRfbXVsdGlwbGllcuKAmSwNCj4gPiAJICAgIGlubGluZWQgZnJvbSDigJhrZWVt
YmF5X3B3bV91cGRhdGVfYml0c+KAmSBhdA0KPiAvaG9tZS91d2UvZ3NyYy9saW51eC9pbmNsdWRl
L2xpbnV4L2JpdGZpZWxkLmg6MTU0OjE6DQo+ID4gCS9ob21lL3V3ZS9nc3JjL2xpbnV4L2luY2x1
ZGUvbGludXgvYml0ZmllbGQuaDoxMTk6MzogZXJyb3I6IGNhbGwgdG8NCj4g4oCYX19iYWRfbWFz
a+KAmSBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSBlcnJvcjogYmFkIGJpdGZpZWxkIG1hc2sNCj4g
PiAJICAxMTkgfCAgIF9fYmFkX21hc2soKTsNCj4gPiAJICAgICAgfCAgIF5+fn5+fn5+fn5+fg0K
PiA+DQo+ID4gVGhlIGNvbXBpbGVyIGRvZXNuJ3Qgc2VlbSB0byBiZSBhYmxlIHRvIG5vdGljZSB0
aGF0IHdpdGggZmllbGQgYmVpbmcNCj4gPiAweDNmZmZmZmYgdGhlIGV4cHJlc3Npb24NCj4gPg0K
PiA+IAlpZiAoKGZpZWxkIHwgKGZpZWxkIC0gMSkpICYgKChmaWVsZCB8IChmaWVsZCAtIDEpKSAr
IDEpKQ0KPiA+IAkJX19iYWRfbWFzaygpOw0KPiA+DQo+ID4gY2FuIGJlIG9wdGltaXplZCBhd2F5
Lg0KPiA+DQo+ID4gU28gdXNlIF9fYWx3YXlzX2lubGluZSBhbmQgZG9jdW1lbnQgdGhlIHByb2Js
ZW0gaW4gYSBjb21tZW50IHRvIGZpeA0KPiA+IHRoaXMuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTog
a2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVXdl
IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gPiAtLS0N
Cj4gPiBIZWxsbywNCj4gPg0KPiA+IEknbSBub3Qgc3VyZSB0aGlzIGlzIHRoZSByaWdodCBmaXgu
IE1heWJlIHRoZSBiaXRmaWVsZCBzdHVmZiBjYW4gYmUNCj4gPiBjaGFuZ2VkIHNvbWVob3cgdG8g
bWFrZSB0aGlzIHByb2JsZW0gZ28gYXdheSwgdG9vPw0KPiANCj4gTm90ZSwgdGhpcyBwYXRjaA0K
PiANCj4gRml4ZXM6IGNkYmVhMjQzZjQxOSAoInB3bTogQWRkIFBXTSBkcml2ZXIgZm9yIEludGVs
IEtlZW0gQmF5IikNCj4gDQo+IHNvIHRoaXMgaXNuJ3QgY3JpdGljYWwgZm9yIHY1LjEwLg0KPiAN
Cj4gQHRoaWVycnk6IElmIHRoaXMgaXMgb2sgZm9yIHlvdSBhbmQgVmlqYXlha2FubmFuLCB5b3Ug
Y2FuIHNxdWFzaCB0aGlzDQo+IGludG8gdGhlIG9yaWdpbmFsIGNvbW1pdC4NCj4gDQoNCkkgYW0g
b2sgd2l0aCBVd2UgYXBwcm9hY2guDQpJIGhhdmUgY29tcGlsZWQgdGhlIGNoYW5nZSBhbmQgdGVz
dGVkIGluIEtlZW1iYXkgYm9hcmQgYXMgd2VsbC4NCg0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+
IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBV
d2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlv
bnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwNCg0KVGhh
bmtzLA0KVmlqYXkNCg==
